class Formatter
  def self.for(type)
    case type
    when 0
      CreatorTask.new
    when 1
      CreatorMemo.new
    when 2
      CreatorLink.new
    else
      raise 'Unsupported type of report'
    end
  end
end