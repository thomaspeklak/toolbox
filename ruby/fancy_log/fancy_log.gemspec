Gem::Specification.new do |s| 
  s.name = "fancylog"
  s.version = "0.0.1"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Wrapper for logger class"
  s.description = "Provides a wrapper for the logger class, enables easy logging to a standard and error log"
  s.files = Dir["lib/**/*"]
	s.bindir = 'bin'
	s.test_files = Dir["{test}/tc_*.rb"].to_a
  s.has_rdoc = true
end