VERSION = "0.2.0"

class MainController < NSObject
  
  attr_accessor :tab, :doc, :frame, :terminal, :webView, :container
  
  def init()
    super
    $main = self # TODO: debug
    return self
  end

  def applicationDidFinishLaunching(notification)
    @frame = @webView.mainFrame
    @content = ""
    @terminal = Terminal.new
    @terminal.mound = $mound
    $mound.reset_all()
    @frame.loadHTMLString("<html><body><pre id=\"container\">Termite v#{VERSION}</br></pre></body></html>", baseURL:nil)
    @terminal.connect()
  end
  
  def get_enclosing_scrollview()
    @frame.frameView.documentView.enclosingScrollView()
  end
  
  def bottom_position()
    sv = get_enclosing_scrollview()
    NSMaxY(sv.documentView.frame)-NSHeight(sv.contentView.bounds)
  end
  
  def scrolled_to_bottom?()
    sv = get_enclosing_scrollview()
    origin = sv.documentVisibleRect.origin
    return origin.y+40 >= bottom_position()
  end
  
  def scroll_to_bottom()
    return unless @doc
    body = @doc.body
    body.setValue_forKey_(body.valueForKey("scrollHeight"), "scrollTop")
  end
  
  def emit_code(code)
    return unless code
    @content += code
    @doc = @webView.mainFrameDocument.taint unless @doc
    @container = @doc.getElementById_("container") unless @container
    return unless @doc and @container
    scroll = scrolled_to_bottom?()
    @container.innerHTML += code
    scroll_to_bottom() if scroll
  end
  
  def showConsole(sender)
    consoleWindowController = ConsoleWindowController.alloc.initWithFrame([50,50,600,300])
    consoleWindowController.run
  end
  
end