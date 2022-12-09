# frozen_string_literal: true

# Factory Method, detects Post children
class Formatter
  def post_types
    Post.types
  end

  def self.for(choice)
    creator_name = "Creator#{choice}"
    creator = Object.const_get creator_name.to_s
    creator.new
    #   raise 'Unsupported type of report'
  end
end
