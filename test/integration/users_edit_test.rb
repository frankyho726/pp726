require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  #10.9 do and 10.17
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)                                                  
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",                        ## error  problem solve check point 10.24
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

 # 10.11 do and 10.17
 test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)                                                  #### problem solve check point 10.24
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,                      
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?                                                     ### fail problem solve check point 10.24
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)                                                  #### problem solve check point 10.24
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)                                  #after 10.15 fail and fix after 10.32
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  
  
end