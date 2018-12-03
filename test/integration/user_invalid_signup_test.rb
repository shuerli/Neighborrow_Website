require 'test_helper'

class UserInvalidSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "invalid signup information" do
  get signup_path
  assert_no_difference 'Account.count' do
      post accounts_path, params: { account: {
      email: "user@invalid",
      password:              "foo",
      password_confirmation: "bar" } }
    end
    assert_template 'accounts/new'
  end

end
