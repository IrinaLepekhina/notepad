class Memo < Post
  attr_accessor :created_at, :text, :postType

  def initialize
    super
    @postType = "Memo"
  end

  def read_from_console #todo
    puts
    puts "Введите текст"
    puts "Запись оканчивается строчкой"
    puts "\"end\""
    puts

    line = nil
    text = []

    until line == "end" do
      line = STDIN.gets.encode("UTF-8").chomp
      @text << line
    end
    @text.pop
  end

  def to_string 
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"
    @text.unshift(time_string)
  end
end

