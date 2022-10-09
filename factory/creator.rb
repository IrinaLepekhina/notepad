class Creator
  def factoryMethod
    Post.new
  end

  def self.generate(type)
    Formatter.for(type).factoryMethod
  end
  

  #не использую. список наследников
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.post_creators
    Creator.descendants
  end
end

