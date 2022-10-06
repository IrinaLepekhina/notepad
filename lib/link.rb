class Link < Post
  attr_accessor :created_at, :text, :url
    
  def initialize
    super
    @url = ""
  end

  def read_from_console 
    puts "Введите адрес ссылки (url): "
    @url = STDIN.gets.chomp

    puts "Введите описание: "
    @text = STDIN.gets.chomp
  end

  def to_string
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"

    [@url,  @text, time_string]
  end
end

