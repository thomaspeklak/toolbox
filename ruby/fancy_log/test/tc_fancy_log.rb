$basename = File.dirname(File.expand_path(__FILE__))
$out = $basename + '/out.log'
$err = $basename + '/err.log'
require 'test/unit'
require File.join($basename, '..', 'lib', 'fancy_log')

class TestFancyLog < Test::Unit::TestCase
	def test_fancy_log
		l = FancyLog.setup(:out_device => $out, :err_device => $err).instance            # create new instance
		assert File.exists? $out
		assert File.exists? $err
		
		l.warn('test') {'testmessage'}                                   # warn message of program 'test' to out log
		assert_equal 1, File.read($out).scan(/testmessage/).size
		assert_equal 0, File.read($err).scan(/testmessage/).size
		
		l.warn_to_err('test') {'testmessage to error'}                   # warn message to err log
		assert_equal 1, File.read($out).scan(/testmessage/).size
		assert_equal 1, File.read($err).scan(/testmessage/).size

		l.fatality_occured_in('test2') { 'something really bad happend'} # fatal message to err log
		assert_equal 0, File.read($out).scan(/something really/).size
		assert_equal 1, File.read($err).scan(/something really/).size
		
		l.information('testmessage')                                     # information to out log
		assert_equal 2, File.read($out).scan(/testmessage/).size
		assert_equal 1, File.read($err).scan(/testmessage/).size

		l.somethingbad('bad')                                            # debug message, because no valid method type => no message because of log level
		assert_equal 0, File.read($out).scan(/bad/).size
		assert_equal 1, File.read($err).scan(/bad/).size
		
		l.set_options(:default_level => 'error')                          # set default level to warn
		l.somethingbad('bad')                                            # warn message, because no valid method type and default level set to warn
		assert_equal 1, File.read($out).scan(/bad/).size
		assert_equal 1, File.read($err).scan(/bad/).size

		l.teardown
		assert_nothing_raised do
			File.delete($out)
			File.delete($err)
		end
	end
end