ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Only users come from fixtures: PostgreSQL can't load dependent fixtures without superuser rights,
    # so items and comments are built with the helpers below instead.
    fixtures :users

    def create_item(user: users(:one), **attrs)
      user.items.create!({ title: "Blue water bottle", status: "lost", location: "Library" }.merge(attrs))
    end
  end
end

class ActionDispatch::IntegrationTest
  setup { @headers = { "User-Agent" => "Mozilla/5.0 (Macintosh) AppleWebKit/605.1.15 Version/18.0 Safari/605.1.15" } }

  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: "password" }, headers: @headers
  end
end
