require 'test_helper'

class StaticpagesControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
###3.43 add "should get root"
 #   test "should get root" do
#    get FILL_IN
 #   assert_response FILL_IN
#  end
###
  
  
  
  test "should get home" do
    get staticpages_home_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
=======
  test "should get home" do
    get staticpages_home_url
    assert_response :success
>>>>>>> static-pages
  end

  test "should get help" do
    get staticpages_help_url
    assert_response :success
<<<<<<< HEAD
    assert_select "title", "Help | #{@base_title}"
=======
>>>>>>> static-pages
  end

  test "should get about" do
    get staticpages_about_url
    assert_response :success
<<<<<<< HEAD
    assert_select "title", "About | #{@base_title}"
  end
  
  test "should get contact" do
    get staticpages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
=======
>>>>>>> static-pages
  end
end
