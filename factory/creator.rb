class Creator
  def factoryMethod
  end

  def self.generate(type)
    Formatter.for(type).factoryMethod
  end
  
end