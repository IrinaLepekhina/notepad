if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'date'
require 'mysql2'

current_path = File.dirname(__FILE__)

require current_path + '/lib/post.rb'
require current_path + '/lib/memo.rb'
require current_path + '/lib/task.rb'
require current_path + '/lib/link.rb'
require current_path + '/lib/connect.rb'

require current_path + '/factory/formatter.rb'
require current_path + '/factory/creator.rb'
require current_path + '/factory/creator_memo.rb'
require current_path + '/factory/creator_task.rb'
require current_path + '/factory/creator_link.rb'


puts 'Привет, я твой блокнот!'
puts
puts 'Что хотите записать в блокнот?'
puts

pt = {"Task" => CreatorTask.new, "Memo" => CreatorMemo.new, "Link" => CreatorLink.new}
creators = pt.values
choice = -1

until choice >= 0 && choice <  pt.size
  creators.each_with_index do |creator, index|
    puts "#{index} create Post:\t #{creator.factoryMethod.post_type}"
  end
  choice = STDIN.gets.chomp.to_i
end

entry = Creator.generate(choice)

entry.read_from_console

table = "posts"
puts query = entry.to_db_hash(table)

id = Connect.new.save_to_db(query)

puts "Запись сохранена, id = #{id}"