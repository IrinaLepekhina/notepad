require "date"

class Task < Post
  attr_accessor :created_at, :text, :due_date, :postType
  
  def initialize
    super
    @due_date = Time.now
    @postType = "Task"
  end
    
  def read_from_console
    puts "Опишите задачу:"
    @text = STDIN.gets.chomp

    puts "до какого числа нужно сделать в формате ДД.ММ.ГГГГ
    например 01.09.2022"
    input = STDIN.gets.chomp
    @due_date = Date.parse(input)

  end

  def to_string
    deadline = "Крайний срок: #{@due_date.strftime('%Y.%m.%d')}"
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"

    [deadline, @text, time_string]
  end
    
end