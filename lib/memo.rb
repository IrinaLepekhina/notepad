# frozen_string_literal: true

# Post child
class Memo < Post
  attr_accessor :created_at, :text, :post_type, :post_id

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
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\r"
    @text.unshift(time_string)
    post_id = "Post id: #{@post_id}\n\r"

    [@text, post_id]
  end

  def to_db_hash
    attr_hash = super.merge({ 'text' => @text.join("\n\r") })

    default_hash.merge(attr_hash)
  end

  def load_data(data_hash)
    super(data_hash)

    @text = data_hash['text'].split('\n\r')
    @post_id = data_hash['post_id']
  end
end
