if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

require current_path + '/lib/post.rb'
require current_path + '/lib/memo.rb'
require current_path + '/lib/task.rb'
require current_path + '/lib/link.rb'

puts 'Привет, я твой блокнот!'
puts
puts 'Что хотите записать в блокнот?'

choice = -1
choices = Post.post_types

until choice >= 0 && choice <  choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = STDIN.gets.chomp.to_i
end

entry = Post.post_create(choice)

entry.read_from_console

entry.save

puts "Запись сохранена"
