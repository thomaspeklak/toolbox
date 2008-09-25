Gem::Specification.new do |s| 
  s.name = "jig_saw"
  s.version = "0.0.1"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "JigSaw is an command line and/or config file parser, options validator, generator and provider."
  s.description = <<-EOS
JigSaw is an command line and/or config file parser, options validator, generator and provider.

JigSaw
- reads command line options
- reads options from a config file
- merges these options together
- validates options and gives meaningful errors to the user if something does not match a criterium
- provides collected options through singleton interface

Usage:
  EOS
  s.files = Dir["{lib,tests}/**/*"]
  s.require_path = "lib"
  s.has_rdoc = true
  s.add_dependency = ""
  s.extra_rdoc_files = ["README"] 
  s.rdoc_options = %w{--main README}
end
