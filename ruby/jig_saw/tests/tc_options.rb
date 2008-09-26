#Test for Options class
$: << File.expand_path(File.dirname(__FILE__)+'/../lib')

require 'test/unit' 
require 'options/options.rb'
require "benchmark"

class OptionsTest < Test::Unit::TestCase 
  def setup
    @options = JigSaw::Options::MainOptions.instance
  end
  
  def test_add_and_retrieve_option
    @options.option= :value
    assert_equal :value, @options.option
    assert_equal [:option], @options.get_options
  end
  
  def test_benchmark
    1000.times do |i|
      a = "bm#{i}"
      @options.send("#{a}=",i)
      t = @options.send(a)
      assert_equal i, t
    end
  end
  
  
  def test_suboptions
    @options.option_with.suboption = 100
    assert_equal 100, @options.option_with.suboption
  end
  
  def test_zzz_immutable  #immutable has to be called last therefor the zzz
    @options.option2
    @options.set_immutable
    assert_raises JigSaw::Options::NoOptionsEntry do
      @options.new_option
    end
    assert_equal nil, @options.option2
  end
  
  def teardown
    
  end
end
