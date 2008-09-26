require 'singleton'
require 'helpers/symbol'
module JigSaw
module Options
  
class Options
  def initialize
    @stored_options = []
  end
  
  def get_options
    @stored_options
  end
  
  def set_immutable
    self.class.class_eval do
      remove_method :method_missing
    end
  end
  
  private
  def method_missing(meth, *args)
    self.class.class_eval do
      attr_accessor meth.skip_equal
    end
    @stored_options << meth.skip_equal unless @stored_options.include? meth.skip_equal
    if args.empty?
      __send__("#{meth}=", Options.new)
    else
      __send__(meth, *args)
    end
  end
end

class MainOptions < Options
  include Singleton
  def set_immutable
    self.class.superclass.class_eval do
      remove_method :method_missing
    end
  end
end

end
end