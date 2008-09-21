$: << File.expand_path(File.dirname(__FILE__)+'/../lib')

require 'test/unit' 
require 'emerald.rb'

class EmeraldTest < Test::Unit::TestCase 
  def setup
    ARGV << 'EmeraldTestCase'
    Emerald.new
  end
  
  def test_emerald_default
    assert_equal ["emerald_test_case",
     "emerald_test_case/bin",
     "emerald_test_case/bin/emerald_test_case",
     "emerald_test_case/emerald_test_case.gemspec",
     "emerald_test_case/lib",
     "emerald_test_case/lib/emerald_test_case.rb",
     "emerald_test_case/rakefile",
     "emerald_test_case/README",
     "emerald_test_case/tests",
     "emerald_test_case/tests/tc_emerald_test_case.rb"], `find emerald_test_case`.split()
  end
  
  def teardown
    `rm -rf emerald_test_case`
  end
end