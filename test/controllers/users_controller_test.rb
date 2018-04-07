require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

end

#test "should get home" do
#    get root_path
#    assert_response :success
 #   assert_select "title", "Ruby on Rails Tutorial Sample App"
 # end