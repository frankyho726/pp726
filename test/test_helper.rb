ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def is_logged_in?
    !session[:user_id].nil?
  end
  # 登入指定的用户
  def log_in_as(user)
    session[:user_id] = user.id
  end
end  
class ActionDispatch::IntegrationTest

  # 登入指定的用户
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
  
  
  include ApplicationHelper  ## 代码清单 5.35：把 Application 辅助模块引入测试

  # Add more helper methods to be used by all tests here...
end
