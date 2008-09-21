require 'fileutils'

class Emerald
  @@USAGE = <<-EOS
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
  def initialize
    case ARGV.length
    when 0
      puts @@USAGE
    when 1
      init_gemname_vars
      unless gem_dir_exists
        create_bin
        create_lib
        create_tests
        create_read_me
        create_rakefile
        create_gemspec
#        initialize_git  if ARGV.inclde?('+git')
      end
    else
      init_gemname_vars
      unless gem_dir_exists
        create_bin      if ARGV.inclde?('bin')
        create_lib      if ARGV.inclde?('lib')
        create_tests    if ARGV.inclde?('tests')
        create_read_me
        create_rakefile if ARGV.inclde?('tests')
        create_gemspec
#        initialize_git  if ARGV.inclde?('+git')
      end
    end
  end
  
  private
  def init_gemname_vars
    @gemname = ARGV.shift
    @gemname.capitailze! unless @gemname.match(/^[A-Z]/)
    @gem_filename = @gemname.gsub(/(.)([A-Z])/,'\1_\2').downcase
  end
  
  def gem_dir_exists
    File.exists?(@gem_filename) && File.directory?(@gem_filename)
  end
  
  def create_bin
    path = create_dir('bin')
    File.open("#{path}/#{@gem_filename}",'w') do |f|
      f.puts <<-EOS
#!/usr/local/bin/ruby -w

require '#{@gem_filename}.rb'
      
      EOS
    end
  end
  
  def create_lib
    path = create_dir('lib')
    File.open("#{path}/#{@gem_filename}.rb",'w') do |f|
      f.puts <<-EOS
##{@gemname}
#
# Description:
#

class #{@gemname}
  def initialize
  
  end
end
      EOS
    end
  end
  
  def create_tests
    path = create_dir('tests')
    File.open("#{path}/tc_#{@gem_filename}.rb",'w') do |f|
      f.puts <<-EOS
#Test for #{@gemname}
$: << File.expand_path(File.dirname(__FILE__)+'/../lib')

require 'test/unit' 
require '#{@gem_filename}.rb'

class #{@gemname}Test < Test::Unit::TestCase 
  def setup

  end
  
  def test_#{@gem_filename}
  
  end
  
  def teardown
    
  end
end
      EOS
    end
  end
  
  def create_read_me
    File.open("#{@gem_filename}/README",'w') do |f|
      f.puts <<-EOS
#{@gemname}

Description:


Usage:
      EOS
    end
  end
  
  def create_rakefile
    File.open("#{@gem_filename}/rakefile",'w') do |f|
      f.puts <<-EOS
$: << File.expand_path(File.dirname(__FILE__)+'/tests')

desc 'perform all tests'
task :tests do
  load 'tc_#{@gem_filename}.rb'
end

desc 'Usage:'
task :default do
  puts <<EOLS
possible tasks:
  tests  : perform all tests in project

  EOLS
      EOS
    end    
  end
  
  def create_gemspec
    File.open("#{@gem_filename}/#{@gem_filename}.gemspec",'w') do |f|
      f.puts <<-EOS
Gem::Specification.new do |s| 
  s.name = "#{@gem_filename.downcase}"
  s.version = "0.0.1"
  s.author = ""
  s.email = ""
  s.platform = Gem::Platform::RUBY
  s.summary = ""
  s.description = ""
  s.files = Dir["{bin,lib,tests}/**/*"]
	s.bindir = 'bin'
	s.executable = '#{@gem_filename}'
  s.require_path = "lib"
  s.has_rdoc = true
  s.add_dependency = ""
  s.extra_rdoc_files = ["README"] 
  s.rdoc_options = %w{--main README}
end
      EOS
    end
  end
  
  def initialize_git
    Dir.chdir(@gem_filename)
    #`git init`
  end
  
  def create_dir(dir)
    path = "#{@gem_filename}/#{dir}"
    FileUtils.mkdir_p(path)
    path
  end
end
