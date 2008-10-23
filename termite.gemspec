Gem::Specification.new do |s|
  s.name = %q{termite}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Antonin Hildebrand"]
  s.date = %q{2008-10-22}
  s.default_executable = %q{termite}
  s.description = %q{Look for termite.* gems on github}
  s.email = %q{antonin@hildebrand.cz}
  s.executables = ["termite"]
  s.files = ["build/Termite.app/Contents", "build/Termite.app/Contents/Info.plist", "build/Termite.app/Contents/MacOS", "build/Termite.app/Contents/MacOS/Termite", "build/Termite.app/Contents/PkgInfo", "build/Termite.app/Contents/Resources", "build/Termite.app/Contents/Resources/English.lproj", "build/Termite.app/Contents/Resources/English.lproj/InfoPlist.strings", "build/Termite.app/Contents/Resources/English.lproj/main.nib", "build/Termite.app/Contents/Resources/English.lproj/main.nib/designable.nib", "build/Termite.app/Contents/Resources/English.lproj/main.nib/keyedobjects.nib", "build/Termite.app/Contents/Resources/lib", "build/Termite.app/Contents/Resources/lib/_appscript", "build/Termite.app/Contents/Resources/lib/_appscript/defaultterminology.rb", "build/Termite.app/Contents/Resources/lib/_appscript/referencerenderer.rb", "build/Termite.app/Contents/Resources/lib/_appscript/reservedkeywords.rb", "build/Termite.app/Contents/Resources/lib/_appscript/safeobject.rb", "build/Termite.app/Contents/Resources/lib/_appscript/terminology.rb", "build/Termite.app/Contents/Resources/lib/appscript.rb", "build/Termite.app/Contents/Resources/lib/kae.rb", "build/Termite.app/Contents/Resources/main.rb", "build/Termite.app/Contents/Resources/src", "build/Termite.app/Contents/Resources/src/api.rb", "build/Termite.app/Contents/Resources/src/console.rb", "build/Termite.app/Contents/Resources/src/controller.rb", "build/Termite.app/Contents/Resources/src/mound.rb", "build/Termite.app/Contents/Resources/src/terminal.rb", "build/Termite.app/Contents/Resources/src/utils.rb", "lib/termite.rb", "bin/termite", "VERSION.yml"]
  s.homepage = %q{http://github.com/woid/termite}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Terminal echoizer}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
