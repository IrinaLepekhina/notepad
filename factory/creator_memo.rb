# frozen_string_literal: true

# Factory Method for Memo
class CreatorMemo < Creator
  def factory_method
    Memo.new
  end
end
