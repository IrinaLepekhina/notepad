# frozen_string_literal: true

# Post child
class Link < Post
  attr_accessor :created_at, :text, :url, :post_type, :post_id

  def initialize
    super
    @url       = ''
    @post_type = 'Link'
  end

  def read_from_console
    puts 'Введите адрес ссылки (url): '
    @url = $stdin.gets.chomp

    puts 'Введите описание: '
    @text = $stdin.gets.chomp
  end

  def to_string
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\r"
    @text.unshift(time_string)
    post_id = "Post id: #{@post_id}\n\r"

    [@url, @text, post_id]
  end

  def to_db_hash
    attr_hash = super.merge({
                              'text' => @text,
                              'url' => @url
                            })

    default_hash.merge(attr_hash)
  end

  def load_data(data_hash)
    super(data_hash)

    @text = data_hash['text']
    @url  = data_hash['url']
  end
end
