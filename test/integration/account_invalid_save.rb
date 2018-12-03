require 'test_helper'

class AccountSaveInvalidTest < ActionDispatch::IntegrationTest
  test "should not save account without email" do
    account = Account.new
    assert_not account.save
  end
end