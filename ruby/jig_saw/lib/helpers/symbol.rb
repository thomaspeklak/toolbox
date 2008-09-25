class Symbol
  def ends_with(value)
    self.to_s[-1,1] == value
  end
  
  def skip_equal
    self.to_s.sub(/=$/,'').to_sym
  end
end
