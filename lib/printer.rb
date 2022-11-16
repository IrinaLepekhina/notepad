# frozen_string_literal: true

# Printer
class Printer
  attr_accessor :arr

  def initialize
    @arr = []
  end

  def table_banner
    print '|       post_id      '
    print '|     @post_type     '
    print '|     @created_at    '
    print '|       @text        '
    print '|        @url        '
    print '|     @due_date      '
    print '|'
  end

  def print_table(post)
    if post.first.nil?
      puts 'Post isn\'t found. See u soon.'
    else
      # Several objects, showing the table
      puts 'Table:'
      table_banner
      post.each do |row|
        puts
        filling_table(row)
      end
      puts
    end
  end

  def filling_table(row)
    # Print table in terminal
    row.each do |element|
      element_text = "| #{element[1].to_s.delete("\n")[0..17]}"
      element_text << ' ' * (21 - element_text.size)

      print element_text
    end
    print '|'
  end

  def print_array(post)
    if post.first.nil?
      puts 'Post isn\'t found. See u soon.'
    else
      puts '', 'Ruby array:'

      to_arr(post)

      # Print array
      arr.each do |element|
        puts element.to_string
      end

    end
  end

  def to_arr(post)
    # Write table to ruby array
    post.each do |row|
      choice = row['post_type']
      post = Creator.generate_read(choice)
      post.load_data(row)
      arr.push(post)
    end
  end
end
