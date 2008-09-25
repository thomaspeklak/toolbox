#Test for Options class
$: << File.expand_path(File.dirname(__FILE__)+'/../lib')

require 'test/unit' 
require 'options/options.rb'
require "benchmark"

class OptionsTest < Test::Unit::TestCase 
  def setup
    @options = JigSaw::Options::Options.instance
  end
  
  def test_add_and_retrieve_option
    @options.option= :value
    assert_equal :value, @options.option
  end
   
  def test_benchmark
    x = 10000
    x.times {|i|
      @options.i = i
      t = @options.i
      assert_equal i, t}
  end
  
  def teardown
    
  end
end
