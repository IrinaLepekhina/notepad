class Creator
  def factory_method
    Post.new
  end

  def self.generate(choice, post_types)
    Formatter.for(choice, post_types).factory_method
  end
  

  #не использую. список наследников
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.post_creators
    Creator.descendants
  end
end

