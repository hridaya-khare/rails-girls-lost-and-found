require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup { @item = create_item }

  test "replying requires sign in" do
    assert_no_difference("Comment.count") do
      post item_comments_url(@item), headers: @headers, params: { comment: { body: "Mine!" } }
    end
  end

  test "signed-in user replies" do
    sign_in_as users(:two)

    assert_difference("Comment.count") do
      post item_comments_url(@item), headers: @headers, params: { comment: { body: "I think that's mine!" } }
    end
  end

  test "author can delete their reply, others cannot" do
    comment = @item.comments.create!(user: users(:two), body: "I saw it at the front desk!")
    other = User.create!(name: "Meera", email_address: "meera@example.com", password: "password")

    sign_in_as other
    assert_no_difference("Comment.count") { delete item_comment_url(@item, comment), headers: @headers }

    sign_in_as users(:two)
    assert_difference("Comment.count", -1) { delete item_comment_url(@item, comment), headers: @headers }
  end
end
