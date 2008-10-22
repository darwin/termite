require 'erb'

class Mound
  attr_accessor :workers, :soldiers, :hero, :watchers
  
  def initialize()
    @workers = []
    @soldiers = []
    @watchers = []
    @hero = nil
    @watcher_index = 0
  end
  
  def reset_all()
    @workers.each do |termite|
      termite.reset()
    end
    @soldiers.each do |termite|
      termite.reset()
    end
    @watchers.each do |termite|
      termite.reset()
    end
  end
  
  def excercise_watchers(line)
    @watchers.each {|watcher| watcher.watch(line) }
  end
  
  def process_line_with_workers(line)
    original = line
    @workers.each do |worker|
      line = worker.eat(original, line)
    end
    line
  end
  
  def process_line(line)
    original = line
    line = ERB::Util::h(line)
    line = process_line_with_workers(line)
    if @hero!=nil
      res = @hero.eat(original, line) if @hero
      return nil if res == true
    end
    
    @hero = nil
    @soldiers.each do |soldier|
      res = soldier.eat(original, line)
      if res
        @hero = soldier
        return nil
      end
    end 
    line
  end
  
  def enter_exclusive_mode()
    NSLog("suspending ...")
    $terminal.suspended = true
  end
  
  def leave_exclusive_mode()
    NSLog("running ...")
    $terminal.suspended = false
  end
  
  def emit_code(code)
    $main.emit_code(code)
  end
  
  def get_content()
    $terminal.get_content()
  end
  
  def peek_prompt()
    $terminal.get_prompt()
  end
  
  def wait_for_content(command, prompt, timeout=4)
    NSLog("wait_for_content: '#{command}'")
    $terminal.wait_for_content(command, prompt, timeout)
  end
  
  def do(command)
    return unless $terminal
    NSLog("do: '#{command}'")
    $terminal.do_shell_script(command)
  end
end
