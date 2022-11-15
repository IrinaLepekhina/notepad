# frozen_string_literal: true

# Factory Method for Link
class CreatorLink < Creator
  def factory_method
    Link.new
  end
end
