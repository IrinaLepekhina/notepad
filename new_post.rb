# frozen_string_literal: true

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'date'
require 'mysql2'

current_path = File.dirname(__FILE__)

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

puts 'Привет, я твой блокнот!'
puts
puts 'Что хотите записать в блокнот?'
puts

types = Formatter.new.post_types

choice = -1

until choice.positive? && choice <= types.size
  types.each do |i, type|
    puts "#{i} create Post:\t #{type}"
  end
  choice = $stdin.gets.chomp.to_i
end

entry = Creator.generate(choice, types)
entry.read_from_console

query = entry.to_db_hash(table = 'posts')

puts table

id = Connect.new.save_to_db(query).inspect

puts "Запись сохранена, id = #{id}"
