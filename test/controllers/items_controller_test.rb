require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create_item(user: users(:one))
    create_item(user: users(:two), title: "Student ID card", status: "found", location: "Canteen")
  end

  test "anyone can browse and filter items" do
    get items_url(status: "found"), headers: @headers
    assert_response :success
    assert_match "Student ID card", response.body
    assert_no_match "Blue water bottle", response.body
  end

  test "anyone can see an item and its replies" do
    @item.comments.create!(user: users(:two), body: "I saw it at the front desk!")
    get item_url(@item), headers: @headers
    assert_response :success
    assert_match "I saw it at the front desk!", response.body
  end

  test "posting an item requires sign in" do
    get new_item_url, headers: @headers
    assert_redirected_to new_session_url
  end

  test "signed-in user posts an item with a photo" do
    sign_in_as users(:one)

    assert_difference("Item.count") do
      post items_url, headers: @headers, params: { item: {
        title: "Red wallet", status: "found", location: "Bus stop",
        photo: fixture_file_upload("wallet.png", "image/png") } }
    end

    item = Item.last
    assert_redirected_to item_url(item)
    assert_equal users(:one), item.user
    assert item.photo.attached?
  end

  test "owner marks an item as returned" do
    sign_in_as users(:one)
    patch item_url(@item), headers: @headers, params: { item: { resolved: true } }

    assert_redirected_to item_url(@item)
    assert @item.reload.resolved?
  end

  test "only the owner can change an item" do
    sign_in_as users(:two)

    get edit_item_url(@item), headers: @headers
    assert_redirected_to item_url(@item)

    patch item_url(@item), headers: @headers, params: { item: { resolved: true } }
    assert_not @item.reload.resolved?

    assert_no_difference("Item.count") { delete item_url(@item), headers: @headers }
  end

  test "owner deletes an item" do
    sign_in_as users(:one)

    assert_difference("Item.count", -1) { delete item_url(@item), headers: @headers }
    assert_redirected_to items_url
  end
end
