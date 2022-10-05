class Link < Post
  attr_accessor :created_at, :text, :url
    
  def initialize
    super
    @url = ""
  end

  def read_from_console #todo
  end

  def to_string #todo
  end
end

