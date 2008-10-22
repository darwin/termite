framework 'Cocoa'
framework 'WebKit'

$: << File.join($:[0], 'lib') # hack for gem loading

require 'rubygems'
require 'appscript'
include Appscript

require 'src/utils'
require 'src/api'
require 'src/console'
require 'src/controller'
require 'src/mound'
require 'src/terminal'

ADDON_DIR = File.expand_path("~/code/termite.*/")
ADDON_EXTENSION = "rb"

def load_addons()
  Dir.glob(ADDON_DIR).each do |addon_dir|
    addons_mask = File.join(addon_dir, "*.#{ADDON_EXTENSION}")
    $: << File.expand_path(addon_dir)
    NSLog("Loading addon: #{addon_dir}")
    Dir.glob(addons_mask).each do |path|
      path = File.expand_path(path)
      NSLog("  require: #{path}")
      require(path)
    end
  end
end

# init application
$mound = Mound.new
load_addons()

# start the Cocoa main loop
NSApplicationMain(0, nil)