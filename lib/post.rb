# frozen_string_literal: true

# Post
class Post
  attr_accessor :created_at, :text, :post_type, :default_hash

  def initialize
    @created_at    = Time.now
    @text          = []
    @post_type     = nil
    @default_hash  = {
      'post_id' => nil, 'post_type' => nil,
      'created_at' => nil, 'text' => nil,
      'url' => nil, 'due_date' => nil
    }
  end

  def read_from_console; end

  def to_string; end

  def self.types
    ObjectSpace.each_object(Class).select { |klass| klass < self }.map.with_index(1) { |x, i| [i, x.name] }.to_h
  end

  def save
    file = File.new(file_path, 'w:UTF-8')
    to_string.each do |string|
      file.puts(string)
    end

    file.close
  end

  def file_path
    current_path = File.dirname(__FILE__)
    file_name    = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H_%M.txt")
    "#{current_path}/../user_data/#{file_name}"
  end

  def to_db_hash(_table)
    { 'post_type' => self.class.name, 'created_at' => @created_at.strftime('%Y-%m-%d').to_s }
  end

  def load_data(data_hash)
    @created_at   = Time.parse(data_hash['created_at'].to_s)
  end
end
