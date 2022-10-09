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
    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H_%M.txt")
    return current_path + "/../user_data/" + file_name
  end
end