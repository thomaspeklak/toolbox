# wrapper for Logger class
#
# uses singleton pattern to ensure that there is only one log in use
# messages can have the same format as for the logger but methods can have different names as long as they contain fatal, error, warn, info or debug. 
# If no match type is found the message level defaults to debug and the out log is used
# if the method contains to_err or to_out then the message is passed to the specified log
#
# example:
#    l = FancyLog.setup(:err_device => 'err.log').instance            # create new instance
#    l.warn('test') {'testmessage'}                                   # warn message of program 'test' to out log
#    l.warn_to_err('test') {'testmessage to error'}                   # warn message to err log
#    l.fatality_occured_in('test2') { 'something really bad happend'} # fatal message to err log
#    l.information('testmessage')                                     # information to out log
#    l.somethingbad('bad')                                            # debug message, because no valid method type
#    l.set_options(:default_level => 'warn')                          # set default level to warn
#    l.somethingbad('bad')                                            # warn message, because no valid method type and default level set to warn

require 'logger'
require 'singleton'

class FancyLog
	include Singleton
	@@defaults = {
		:out_device => STDOUT,
		:out_level  => Logger::INFO,
		:err_device => STDERR,
		:err_level  => Logger::INFO,
		:format 		=> "%Y-%m-%d %H:%M:%S",
		:errs_to_err => true,
		:default_level => 'debug'
	}
	#initialize 2 loggers out end error
	def initialize
		@out = Logger.new(@@defaults[:out_device])
		@err = Logger.new(@@defaults[:err_device])
	end
	
	# set options on class before initialization
	def self.setup(options = {})
		@@defaults.update(options)
		self.instance.set_options(options)
		self
	end
	
	# apply options, log devices can not change after initialization
	def set_options(options = {})
		@@defaults.update(options)
		@out.level = @@defaults[:out_level]
		@err.level = @@defaults[:out_level]
		@err.datetime_format = @out.datetime_format = @@defaults[:format]
	end
	
	# delete logger objects
	def teardown
		@out.close
		@err.close
	end
	
	private
	# send logger objects methods, messages and blocks
	def method_missing(meth,*args, &blk)
		meth = meth.to_s
		msg =args.shift
		logger(meth).send(meth[/fatal|error|warn|info|debug/] || @@defaults[:default_level], msg, &blk)
	end
	
	# determine which logger object should be used
	def logger(meth)
		case meth
		when /to_err/
			@err
		when /to_out/
			@out
		else
			@@defaults[:errs_to_err] && meth[/fatal|error/] ? @err : @out
		end
	end
end