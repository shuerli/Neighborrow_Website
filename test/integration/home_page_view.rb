require 'test_helper'
 
class WebsiteFlowTest < ActionDispatch::IntegrationTest
  test "can see the welcome page" do
    get "/"
    assert_select "h1", "pages#main"
  end
end