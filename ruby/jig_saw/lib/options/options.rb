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
      define_method :method_missing do |meth, *args|
        raise NoOptionsEntry, "no option #{meth} defined"
      end
    end
    set_unset_values_to_nil
  end
  
  #TODO Iterator over tree
  def each
  
  end
  
  #TODO Tree to_hash
  def to_hash
    
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
  def set_unset_values_to_nil
    @stored_options.each do |o|
      if __send__(o).class == JigSaw::Options::Options
        if __send__(o).get_options.empty?
          __send__("#{o}=", nil)
        else
          __send__(o).set_immutable
        end
      end
    end
  end
  
end

class MainOptions < Options
  include Singleton
end

class NoOptionsEntry < Exception

end

end
end