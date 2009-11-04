require File.dirname(__FILE__) + '/../test_helper'
require 'user_controller'
class UserControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @controller = UserController.new
    @request    = ActionController::TestRequest.new
    user = users(:users_002)
    @request.session[:id] = user.id
    @request.session[:role] = "User"
    @response   = ActionController::TestResponse.new
  end
  
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_rss_types)
    assert_not_nil assigns(:rss_types)
  end
  
  def test_add_type
    get :add_type
    assert_response :success
    assert_not_nil assigns(:rss_types)
    @user_rss_types=assigns(:user_rss_types)
    assert_not_equal 0,@user_rss_types.length,"should not be same"
    @rss_types=assigns(:rss_types)
    assert_not_equal 0,@rss_types.length,"should not be same"
  end
  
  def test_sub_index
    get :sub_index
    assert_response :success
    get :sub_index ,:delete_id=>2
    assert_not_nil assigns(:user_rss_types)
    assert_not_nil assigns(:rss_types)
  end
  
  def test_view_article
    get :view_article,:id=>3
    assert_not_nil assigns(:rss_content)
    @rss_content = assigns(:rss_content)
    assert_instance_of RssContent, @rss_content, "It is not a Rss Content Record"
  end
  
  def test_view_rss
    get :view_rss,:rss_id=>2
    assert_not_nil assigns(:user_rss_type)
    assert_not_nil assigns(:rss_type)
    @user_rss_type = assigns(:user_rss_type)
    @rss_type = assigns(:rss_type)
    assert_instance_of RssType, @rss_type,"It is not a  rss type"
  end
  
end
