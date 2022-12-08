# frozen_string_literal: true

# Factory Method, detects Post children
class Formatter
  def post_types
    Post.types
  end

  def self.for(choice)
    post_creator = "Creator#{choice}"
    one = Object.const_get post_creator.to_s
    one.new
    #   raise 'Unsupported type of report'
  end
end
