class Task < Post
  attr_accessor :created_at, :text, :due_date
  
  def initialize
    super
    @due_date = Time.now
  end
    
  def read_from_console #todo
  end

  def to_string #todo
  end
    
end