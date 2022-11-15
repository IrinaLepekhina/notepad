# frozen_string_literal: true

# Factory Method Parent, for Post
class Creator
  def factory_method
    Post.new
  end

  def self.generate(choice, types)
    Formatter.for(choice, types).factory_method
  end

  def self.generate_read(choice)
    Formatter.read_for(choice).factory_method
  end

  # не использую. список наследников
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.post_creators
    Creator.descendants
  end
end
