#Test for XmlBatchValidator
$: << File.expand_path(File.dirname(__FILE__)+'/../lib')

require 'test/unit' 
require 'xml_batch_validator.rb'

class XmlBatchValidatorTest < Test::Unit::TestCase 
  def setup
		@path = File.expand_path(File.dirname(__FILE__))
  end
  
  def test_xml_batch_validator
		assert_equal ['invalid.xml'], XmlBatchValidator.new(@path + '/testfiles/*.xml').validate.map {|f| File.basename(f)}
  end
  
  def teardown
    
  end
end
