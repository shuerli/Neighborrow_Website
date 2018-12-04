:owner, :condition, :time_start, :time_end, :name

require 'test_helper'

class AccountsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

   test "valid signup information" do
       get signup_path
       assert_difference 'Item.count', 1 do
           post user_items_path, params: {item: {category_id:'2',
             address:3,
             owner:'raymondfzy@gmail.com', 
             photo_url:'/assets/img/Video Games/GTA5.jpeg', 
             condition:'Good', 
             rate_level: 4, 
             time_start:'2018-12-25 00:00:00', 
             time_end: '2019-01-15 00:00:00', 
             name:'GTA 5', 
             description:'Sharing my games during Christmas. Just remember don\'t start a new game cuz it will overwrite my saved game.', 
             brand:'Rock Star'} }
       end
       follow_redirect!
       assert_equal 200, status
   end

end
