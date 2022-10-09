class Creator
  def factoryMethod
    Post.new
  end

  def self.generate(type)
    Formatter.for(type).factoryMethod
  end
  
end