require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "sign up creates a user and signs them in" do
    assert_difference("User.count") do
      post registration_url, headers: @headers, params: { user: {
        name: "Zoya", email_address: "zoya@example.com", password: "secret123", password_confirmation: "secret123" } }
    end

    assert_redirected_to root_url
    assert cookies[:session_id].present?
  end

  test "sign up with a used email shows errors" do
    post registration_url, headers: @headers, params: { user: {
      name: "Copy", email_address: users(:one).email_address, password: "x", password_confirmation: "x" } }

    assert_response :unprocessable_content
  end
end
