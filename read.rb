# frozen_string_literal: true

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'date'
require 'time'
require 'mysql2'

current_path = File.dirname(__FILE__)

require "#{current_path}/lib/opt_parse.rb"
require "#{current_path}/lib/script_options.rb"

require "#{current_path}/lib/post.rb"
require "#{current_path}/lib/memo.rb"
require "#{current_path}/lib/task.rb"
require "#{current_path}/lib/link.rb"
require "#{current_path}/lib/connect.rb"

require "#{current_path}/factory/formatter.rb"
require "#{current_path}/factory/creator.rb"
require "#{current_path}/factory/creator_memo.rb"
require "#{current_path}/factory/creator_task.rb"
require "#{current_path}/factory/creator_link.rb"

require 'optparse'
require 'optparse/time'
require 'ostruct'

pp options = Optparse.new.parse(ARGV)

post = Connect.new.read_from_db(options.limit, options.id, options.type)

if post.is_a? Post
  # один объект класса Post
  puts "Запись #{post.class.name}, id = #{options.id}"

  puts post.to_string
elsif post.nil?
  puts 'See u soon'
else
  # несколько объектов, показываем таблицу

  print '|       post_id      '
  print '|     @post_type     '
  print '|     @created_at    '
  print '|       @text        '
  print '|        @url        '
  print '|     @due_date      '
  print '|'

  post.each do |row|
    puts

    row.each do |element|
      element_text = "| #{element.to_s.delete("\n")[0..17]}"

      element_text << ' ' * (21 - element_text.size)

      print element_text
    end

    print '|'
  end

  puts
end
