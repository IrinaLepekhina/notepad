# frozen_string_literal: true

# Factory Method, detects Post children
class Formatter
  def post_types
    Post.types
  end

  def self.for(choice, types)
    case types[choice]
    when 'Memo'
      CreatorMemo.new
    when 'Link'
      CreatorLink.new
    when 'Task'
      CreatorTask.new
    else
      raise 'Unsupported type of report'
    end
  end

  def self.read_for(choice)
    case choice
    when 'Memo'
      CreatorMemo.new
    when 'Link'
      CreatorLink.new
    when 'Task'
      CreatorTask.new
    else
      raise 'Unsupported type of report'
    end
  end
end
