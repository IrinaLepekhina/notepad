class Memo < Post
  attr_accessor :created_at, :text

  def read_from_console #todo
    puts "Дневник"
    puts "запись оканчивается строчкой \"end\" в файле."
    puts

    line = nil
    text = []

    while line != "end" do
      line = STDIN.gets.encode("UTF-8").chomp
      text << line
    end
    text.pop
  end

  def to_string 
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"
    @text.unshift(time_string)
  end
end