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

require current_path + '/factory/formatter.rb'
require current_path + '/factory/creator.rb'
require current_path + '/factory/creator_memo.rb'
require current_path + '/factory/creator_task.rb'
require current_path + '/factory/creator_link.rb'


puts 'Привет, я твой блокнот!'
puts
puts 'Что хотите записать в блокнот?'

creators = [CreatorTask.new, CreatorMemo.new, CreatorLink.new]
choice = -1

until choice >= 0 && choice <  creators.size
  creators.each do |creator|
    puts "#{creator.class} create Product:\t #{creator.factoryMethod.postType}"
  end
  choice = STDIN.gets.chomp.to_i
end

entry = Creator.generate(choice)

entry.read_from_console

entry.save

puts "Запись сохранена"