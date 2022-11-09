class Memo < Post
  attr_accessor :created_at, :text, :post_type

  def initialize
    super
    @post_type = "Memo"
  end

  def read_from_console
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

  def to_db_hash(table)
    attr_hash = super.merge({"text" => @text.join("\n\r")})

    db_hash = @@default_hash.merge(attr_hash)

    substituted_columns = db_hash.keys.map { '?' }.join(', ')
    
    prepared_query = "INSERT INTO #{table} VALUES (#{substituted_columns});"
    
    values = db_hash.values
    
    {prepared_query: prepared_query, values: values}
  end
end