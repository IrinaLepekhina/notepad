# frozen_string_literal: true

# Factory Method for Task
class CreatorTask < Creator
  def factory_method
    Task.new
  end
end
