require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "needs a body" do
    assert_not Comment.new(item: create_item, user: users(:two)).valid?
  end
end
