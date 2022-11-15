# frozen_string_literal: true

# Post child
class Memo < Post
  attr_accessor :created_at, :text, :post_type

  def initialize
    super
    @post_type = 'Memo'
  end

  def read_from_console
    puts '', 'Введите текст'
    puts 'Запись оканчивается строчкой'
    puts '"end"', ''

    line = nil

    until line == 'end'
      line  = $stdin.gets.encode('UTF-8').chomp
      @text << line
    end

    @text.pop
  end

  def to_string
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"
    @text.unshift(time_string)
  end

  def to_db_hash(table)
    attr_hash = super.merge({ 'text' => @text.join("\n\r") })
    db_hash   = default_hash.merge(attr_hash)

    substituted_columns = db_hash.keys.map { '?' }.join(', ')
    prepared_query      = "INSERT INTO #{table} VALUES (#{substituted_columns});"
    values              = db_hash.values

    { prepared_query: prepared_query, values: values }
  end

  def load_data(data_hash)
    super(data_hash)

    @text = data_hash['text'].split('\n\r')
  end
end
