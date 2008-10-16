$spec = Gem::Specification.new do |s| 
  s.name = "xml_batch_validator"
  s.version = "0.0.1"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "batch validates XML files"
  s.files = Dir["{bin,lib,tests}/**/*"]
	s.bindir = 'bin'
	s.executable = 'xml_batch_validator'
  s.require_path = "lib"
  s.has_rdoc = true
	s.add_dependency('libxml-ruby')
  s.extra_rdoc_files = ["README"] 
  s.rdoc_options = %w{--main README}
end
