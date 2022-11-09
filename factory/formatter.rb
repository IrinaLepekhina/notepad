class Formatter

  def self.for(choice, post_types)
    case post_types[choice]
    when "Memo"
      CreatorMemo.new
    when "Link"
      CreatorLink.new
    when "Task"
      CreatorTask.new
    else
      raise 'Unsupported type of report'
    end
  end
end