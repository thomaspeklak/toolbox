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
    10_000.times {|i|
      @options.i = i
      t = @options.i
      assert_equal i, t}
  end
  
  def test_suboptions
    
  end
  
  def test_immutable
    @options.set_immutable
    assert_raises NoMethodError do
      @options.new_option
    end
  end
  
  def teardown
    
  end
end
