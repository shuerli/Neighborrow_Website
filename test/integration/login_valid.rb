require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest

  test "valid log in" do
    # get the login page
    get "/login"
    assert_equal 200, status

    # post the login and follow through to the home page
    post "/login", params: { account: {email: "geling.li@mail.utoronto.ca", password:"12345" } }
    follow_redirect!
    assert_equal 200, status
  end
end