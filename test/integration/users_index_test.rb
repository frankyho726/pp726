require 'test_helper'
## 10.48 add for test index
class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @non_admin = users(:archer) #10.62 do
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
  
  
end