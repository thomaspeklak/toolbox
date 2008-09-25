require 'singleton'
require 'helpers/symbol'
module JigSaw
module Options
  
class Options
  include Singleton
  def initialize
    
  end
  
  private
  def method_missing(meth, *args)
    self.class.class_eval do
      attr_accessor meth.skip_equal
    end
    __send__(meth, *args)
  end
end

end
end

