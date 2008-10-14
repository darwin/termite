require 'io/wait'

class Terminal
  attr_accessor :tab, :suspended, :term
  
  PIPE_PATH = "/Users/woid/.Termite"
  
  def initialize()
    $terminal = self
    @last = ""
    @suspended = false
    @stopped = false
    @term = app('Terminal')
    @term.activate()
  end
  
  def find_terminal_tab(title)
    @term.windows.get.each do |win|
      begin
        win.tabs.get.each do |tab|
          tab_title = tab.custom_title.get()
          return tab if tab_title == title || tab_title == "#{title}+SIMBL"
        end
      rescue
        NSLog("Problem with asking terminal window: #{win}")
      end
    end
    nil
  end
  
  def taint_tab(title)
    # see http://www.nach-vorne.de/2007/11/22/terminal-trick
    # and http://onrails.org/articles/2007/11/28/scripting-the-leopard-terminal
    # and http://blog.cbciweb.com/articles/2008/05/02/scripting-mac-terminal-using-ruby
    current_window = @term.windows.first.get()
    @tab = current_window.selected_tab
    @tab.background_color.set([0,10000,10000]) # TODO: remove - debug
    @tab.title_displays_custom_title.set(true)
    @tab.custom_title.set(title)
  end
  
  def do_shell_script(script)
    @tab.do_script(script, :in => @tab)
  end
  
  def mound=(val)
    @mound = val
  end
  
  def run_polling
    NSLog("Starting polling ...")
  end
  
  def run_pipe
    NSLog("Opening pipe ...")
    NSLog("IS PIPE") if File.pipe?(PIPE_PATH)
    @pipe = File.open(PIPE_PATH, "r");
  end
  
  def connect
    # reuse existing Termite tab or create a new one
    @tab = find_terminal_tab("Termite")
    taint_tab("Termite") unless @tab
    
    # detect if SIMBL is active
    if @tab.custom_title.get() == "Termite+SIMBL"
      # SIMBL is active
      # run pipe communication
      run_pipe()
    else
      # SIMBL is not available
      # run slower and more CPU intensive polling
      run_polling() 
    end
    
    content = get_content()
    prompt = get_prompt()
    @last = content
    @dirty = true
    @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:"tick:", userInfo:nil, repeats:true)
  end
  
  def get_prompt()
    begin
      # here I use contents which should return only visible text in terminal window
      # we expect the prompt to fit on the screen
      current = String.new(@tab.contents.get())
    rescue
      NSLog("Terminal lost: #{$!}")
      @stopped = true
      raise
    end
    # terminal output may contain bunch of trailing \n
    # this is case when screen is empty, terminal has alredy created text buffer for visible area
    # remove trailing newlines here
    while current[-1].chr=="\n" do
      current.chop!
    end
    # split text into last line (prompt) and rest (content)
    nl = current.rindex("\n")
    prompt = current[nl..-1]
    prompt.strip
    rescue
    NSLog("get_prompt failed: " + $!)
    ""
  end
  
  def get_content()
    unless @pipe
      # taking whole history is inefficient
      # but unfortunatelly, there is no other API to read content incrementally.
      # TODO: !!! DO NOT set document scrollback limit in Terminal.app preferences (Settings -> Window -> Scrollback)
      begin
        current = String.new(@tab.history.get())
      rescue
        NSLog("Terminal lost: #{$!}")
        @stopped = true
        raise
      end
      # terminal output may contain bunch of trailing \n
      # this is case when screen is empty, terminal has alredy created text buffer for visible area
      # remove trailing newlines here
      while current[-1].chr=="\n" do
        current.chop!
      end
      # split text into last line (prompt) and rest (content)
      nl = current.rindex("\n")
      content = current[0...nl]
      slice = content[@last.size+1..-1]
      @last = content
    else
      # pipe communication is much more efficient
      ready = @pipe.ready?
      slice = @pipe.sysread(ready) if ready
      if slice
        while slice[-1].chr=="\n" do
          slice.chop!
        end
        sleep 0.2 # we are too fast, give terminal.app some time to update it's contents
      end
      begin
        # here I use contents which should return only visible text in terminal window
        # we expect the prompt to fit on the screen
        current = @tab.contents.get() 
      rescue
        NSLog("Terminal lost: #{$!}")
        @stopped = true
        raise
      end
      # terminal output may contain bunch of trailing \n
      # this is case when screen is empty, terminal has alredy created text buffer for visible area
      # remove trailing newlines here
      while current[-1].chr=="\n" do
        current.chop!
      end
      # split text into last line (prompt) and rest (content)
      nl = current.rindex("\n")
    end
    slice
    rescue
    NSLog("get_content failed: " + $!)
    ""
  end

  def tick(object)
    # polling tab's history on timer is bad thing (it eats too much of CPU), but I didn't find a better solution
    return if @stopped # timer is stopped when connection to the terminal has been lost
    return if @suspended # timer is suspended when someone enters into exclusive mode
    slice = get_content()
    prompt = get_prompt()
    if slice && slice.size>0
      @dirty = true 
      lines = slice.split("\n", -1)
      lines.each do |line|
        out = @mound.process_line(line)
        $main.emit_code(out+"<br/>") if out
      end
    end
    if prompt.size>0 and @dirty
      @mound.excercise_watchers(prompt)
      @dirty = false
    end
  end
  
  def wait_for_content(command, prompt, timeout=4, skip_first_line=true)
    data = ""
    @tab.do_script(command, :in => @tab)
    while timeout>=0
      slice = get_content()
      #NSLog("slice: '#{slice}'")
      if slice
        if skip_first_line
          lines = slice.split("\n")
          lines.shift
          slice = lines.join("\n")
          skip_first_line = false
        end
        data = data + slice 
      end
      return data if not skip_first_line and get_prompt()=~prompt
      Kernel::sleep 0.1
      timeout = timeout - 0.1
    end
    NSLog("DATA TIMEOUT: Terminal.app died? or CPUs are busy?")
    nil
  end
end