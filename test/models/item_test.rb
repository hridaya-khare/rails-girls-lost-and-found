require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "needs a title, location and a valid status" do
    item = Item.new(user: users(:one), status: "misplaced")

    assert_not item.valid?
    assert_includes item.errors[:title], "can't be blank"
    assert_includes item.errors[:location], "can't be blank"
    assert_includes item.errors[:status], "is not included in the list"
  end

  test "photo must be an image" do
    item = create_item
    item.photo.attach(io: StringIO.new("hello"), filename: "notes.txt", content_type: "text/plain")

    assert_not item.valid?
    assert item.errors[:photo].any?
  end
end
