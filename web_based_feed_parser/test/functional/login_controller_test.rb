require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'

class LoginControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @controller = LoginController.new
    @request    = ActionController::TestRequest.new
    #user = users(:users_002)
    #@request.session[:id] = user.id
    @response   = ActionController::TestResponse.new
  end

  
  def test_authentication
    get :authentication
    assert_response :success 
    assert_nil assigns(:logged_in_user)
    put :authentication, :user=>{:user_name=>"user",:password=>"wrongpassword"}
    assert_nil assigns(:logged_in_user)
    assert_equal 'Invalid user', flash[:notice]
    put :authentication, :user=>{:user_name=>"user",:password=>"password"}
    assert_not_nil assigns(:logged_in_user)
    assert_valid assigns(:logged_in_user)
    assert_equal 'User', session[:role]
    assert_equal 'User', session[:name]
    assert_redirected_to :controller=>"user",:action=>"index"
    put :authentication, :user=>{:user_name=>"admin",:password=>"password"}
    assert_not_nil assigns(:logged_in_user)
    assert_valid assigns(:logged_in_user)
    assert_equal 'Admin', session[:role]
    assert_equal 'Administrator', session[:name]
    assert_redirected_to :controller=>"admin",:action=>"index"
  end
  
  def test_index
    get :index
    assert_response :success
  end
  
  def test_logout
    get :logout
    assert_equal 'Logged out successfully', flash[:notice]
    assert_redirected_to :action=>"authentication"
    assert_nil(session[:id],"Session not cleared")
    assert_nil(session[:name],"Session not cleared")
  end
  
  def test_new_user
    get :new_user
    assert_response :success
    put :new_user, :user=>{:name=>"jeya",:mobile=>"99999992922",:email=>"email@email.com",:user_name=>"userx",:password=>"password",:cpassword=>"password"}
    assert_equal 'User', session[:role]
    assert_redirected_to :controller=>"user",:action=>"index"
  end
end