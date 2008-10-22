def load_nib(path, owner)
  app = NSApplication.sharedApplication
  table = NSDictionary.dictionaryWithObject(owner || app, forKey: "NSOwner")
  NSBundle.loadNibFile(path, externalNameTable: table, withZone: nil) # TODO: retrieve application zone here
end  