class Post
  attr_accessor :created_at, :text, :postType

  def initialize
    @created_at = Time.now
    @text = []
    @postType = nil
  end

  def read_from_console
  end

  def to_string
  end

  def save
    file = File.new(file_path, "w:UTF-8")
    to_string.each  do |string|
      file.puts(string)
    end

    file.close
  end

  def file_path
    current_path = File.dirname(__FILE__)
    # file_time = @created_at.strftime('%Y-%m-%d_%H-%M-%S')
    # "#{current_path}/user_data/#{self.class.name}_#{file_time}.txt"

    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H_%M.txt")
    return current_path + "/user_data/" + file_name
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.post_types
    Post.descendants
  end

  def self.post_create(type_index)
    post_types[type_index].new
  end
end