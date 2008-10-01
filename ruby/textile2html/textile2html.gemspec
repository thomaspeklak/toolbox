$spec = Gem::Specification.new do |s| 
  s.name = "textile2html"
  s.version = "0.0.1"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = ""
  s.description = ""
  s.files = Dir["{bin}/**/*"]
	s.bindir = 'bin'
	s.executable = 'textile2html'
  s.has_rdoc = true
  s.add_dependency("RedCloth")
  s.extra_rdoc_files = ["README"] 
  s.rdoc_options = %w{--main README}
end
