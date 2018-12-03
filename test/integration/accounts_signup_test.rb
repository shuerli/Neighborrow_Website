require 'test_helper'

class AccountsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

   test "valid signup information" do
       get signup_path
       assert_difference 'Account.count', 1 do
           post accounts_path, params: { account: {email: "user@example.com", password:"password",password_confirmation: "password" } }
       end
       follow_redirect!
       assert_template 'accounts/show'
   end

end
