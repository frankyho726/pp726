require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  #10.20 do
  def setup
    @user       = users(:michael)
    #20.24 do
    @other_user = users(:archer)
  end
  
  #10.34 do index test
    test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  test "should get new" do
    get signup_path                                                         ####
    assert_response :success
  end
   #10.20 do
test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?                                                 ###### fail if do 10.19
    assert_redirected_to login_url
  end
   #10.20 do
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url                                          ###### fail if do 10.19
  end
#10.56 do
test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:             "foobar",
                                            password_confirmation: "foobar",
                                            admin: true } }
    assert_not @other_user.reload.admin?    # 10.56 remark not sure correct command or not
  end

#10.24 do
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)                                                 
    assert flash.empty?
    assert_redirected_to root_url                                             #######
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,                
                                              email: @user.email } }
    assert flash.empty?                                                       #######
    assert_redirected_to root_url
  end
#10.61 do  
 test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end

