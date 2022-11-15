# frozen_string_literal: true

require 'date'

# Post child
class Task < Post
  attr_accessor :created_at, :text, :due_date, :post_type

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
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"

    [deadline, @text, time_string]
  end

  def to_db_hash(table)
    attr_hash = super.merge({
                              'text' => @text,
                              'due_date' => @due_date.to_s
                            })

    db_hash = default_hash.merge(attr_hash)

    substituted_columns = db_hash.keys.map { '?' }.join(', ')
    prepared_query      = "INSERT INTO #{table} VALUES (#{substituted_columns});"
    values              = db_hash.values

    { prepared_query: prepared_query, values: values }
  end

  def load_data(data_hash)
    super(data_hash)

    @text     = data_hash['text']
    @due_date = Date.parse(data_hash['due_date'])
  end
end
