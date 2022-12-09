# frozen_string_literal: true

require 'date'

# Post child
class Task < Post
  attr_accessor :created_at, :text, :due_date, :post_type, :post_id

  def initialize
    super
    @due_date  = Time.now
    @post_type = 'Task'
  end

  def read_from_console
    puts 'Опишите задачу:'
    @text = $stdin.gets.chomp

    puts "до какого числа нужно сделать в формате ДД.ММ.ГГГГ
    например 01.09.2022"
    input     = $stdin.gets.chomp
    @due_date = Date.parse(input)
  end

  def to_string
    deadline    = "Крайний срок: #{@due_date.strftime('%Y.%m.%d')}"
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\r"
    post_id = "Post id: #{@post_id}\n\r"

    [deadline, @text, time_string, post_id]
  end

  def to_db_hash
    attr_hash = super.merge({
                              'text' => @text,
                              'due_date' => @due_date.to_s
                            })

    @@default_hash.merge(attr_hash)
  end

  def load_data(data_hash)
    super(data_hash)

    @text     = data_hash['text']
    @due_date = Date.parse(data_hash['due_date'].to_s)
    @post_id  = data_hash['post_id']
  end
end
