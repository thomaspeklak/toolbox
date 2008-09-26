$spec = Gem::Specification.new do |s| 
  s.name = "emerald"
  s.version = "0.0.4"
  s.author = "Thomas Peklak"
  s.email = "thomas.peklak@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Creates a default gem structure"
  s.description = <<-EOS
  Emerald creates a bare directory structure for a gem, the default structure is. If any options are specified only the specified directory structures are created
    [gemname]
      - bin
        [gemname]
      - lib
        [gemname].rb
      - tests
        tc_[gemname].rb
      rakefile
      README
      [gemname].gemspec
      
  Usage:
    emerald gemname [options]
    
  Options:
    bin, lib, tests: creates directories for bin, lib, tests
    +git: performs a git init on main directory, this is not done by default
  EOS
  s.files = Dir["{bin,lib,tests}/**/*"]
	s.bindir = 'bin'
	s.executable = 'emerald'
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"] 
  s.rdoc_options = %w{--main README}
end