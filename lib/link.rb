# frozen_string_literal: true

# Post child
class Link < Post
  attr_accessor :created_at, :text, :url, :post_type

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
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}\n\r"

    [@url, @text, time_string]
  end

  def to_db_hash(table)
    attr_hash = super.merge({
                              'text' => @text,
                              'url' => @url
                            })

    db_hash = default_hash.merge(attr_hash)

    substituted_columns = db_hash.keys.map { '?' }.join(', ')
    prepared_query      = "INSERT INTO #{table} VALUES (#{substituted_columns});"
    values              = db_hash.values

    { prepared_query: prepared_query, values: values }
  end

  def load_data(data_hash)
    super(data_hash)

    @text = data_hash['text']
    @url  = data_hash['url']
  end
end
