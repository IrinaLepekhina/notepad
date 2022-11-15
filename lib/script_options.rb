# frozen_string_literal: true

# Define menu options
class ScriptOptions < Optparse
  attr_accessor :limit, :type, :id

  def initialize
    super
    self.limit = nil
    self.type  = nil
    self.id    = nil
  end

  def define_options(parser)
    parser.banner = 'Usage: read.rb options'
    parser.separator ''
    parser.separator 'Specific options:'

    # add additional options
    limit_shown_posts_option(parser)
    specify_post_type_option(parser)
    choise_id_option(parser)

    parser.separator ''
    parser.separator 'Common options:'
    # No argument, shows at tail.  This will print an options summary.
    # Try it and see!
    parser.on_tail('-h', '--help', 'Show this message') do
      puts parser
      exit
    end
  end

  def limit_shown_posts_option(parser)
    parser.on('--limit NUMBER', Integer, "сколько последних постов показать \
      (по умолчанию все)") do |limit|
      self.limit = limit
    end
  end

  def choise_id_option(parser)
    parser.on('--id POST_ID', Integer, "если задан id — показываем подробно \
      только этот пост") do |id|
      self.id = id
    end
  end

  def specify_post_type_option(parser)
    parser.on('--type POST_TYPE', %w[Memo Link Task], "какой тип постов показывать \
      (по умолчанию любой: Memo, Link, Task)") do |type|
      self.type = type
    end
  end
end
