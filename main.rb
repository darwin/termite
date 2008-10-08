#
# rb_main.rb
# termite
#
# Created by Antonin Hildebrand on 9/20/08.
# Copyright __MyCompanyName__ 2008. All rights reserved.
#

# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'
framework 'WebKit'

$: << File.join($:[0], 'lib') # hack for gem loading

require 'rubygems'
require 'appscript'
include Appscript

BUNDLE_DIR = "/Users/woid/code/termite-bundles/"
BUNDLE_EXTENSION = "bundle"
ADDON_DIR = "/Users/woid/code/termite-addons/"
ADDON_EXTENSION = "rb"

def main_init
  path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

def load_bundles
  bundles_mask = File.join(BUNDLE_DIR, "*.#{BUNDLE_EXTENSION}")
  Dir.glob(bundles_mask).each do |path|
    path = File.expand_path(path)
    NSLog("Loading bundle: #{path}")
    NSBundle.bundleWithPath(path).load
  end
end

def load_addons
  $LOAD_PATH.insert(1, ADDON_DIR)
  addons_mask = File.join(ADDON_DIR, "*.#{ADDON_EXTENSION}")
  Dir.glob(addons_mask).each do |path|
    path = File.expand_path(path)
    NSLog("Loading addon: #{path}")
    require(path)
  end
end

# init application
main_init
$mound = Mound.new
load_bundles
load_addons

# start the Cocoa main loop
NSApplicationMain(0, nil)