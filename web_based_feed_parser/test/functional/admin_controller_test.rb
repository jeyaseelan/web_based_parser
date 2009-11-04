require File.dirname(__FILE__) + '/../test_helper'
require 'admin_controller'

class AdminControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    user = users(:users_001)
    @request.session[:id] = user.id
    @request.session[:role] = "Admin"
    @response   = ActionController::TestResponse.new
  end
  
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:rss_content)
    @rss_content = assigns(:rss_content)
    assert_instance_of RssContent, @rss_content, "It is not a Rss Content Record"
  end
  
  def test_manage_rss_type
    get :manage_rss_type
    assert_response :success
    assert_not_nil assigns(:rss_types)
    @rss_types=assigns(:rss_types)
    assert_not_equal 0,@rss_types.length,"should not be same"
  end
  
  def test_new_edit_rss
    get :new_edit_rss
    assert_response :success
    get :new_edit_rss ,:id=>2
    assert_not_nil assigns(:rss_type)
    @rss_type = assigns(:rss_type)
    assert_equal 'true', flash[:sucess]
  end
  
  def test_new_edit_rss_content
    get :new_edit_rss_content,:id=>20,:rss_type_id=>5
    assert_not_nil assigns(:rss_content)
    assert_not_nil assigns(:rss_type)
    @rss_type=assigns(:rss_type)
    @rss_content=assigns(:rss_content)
    assert_instance_of RssContent, @rss_content, "It is not a Rss Content Record"
    assert_instance_of RssType, @rss_type, "It is not a Rss Content Record"
  end
  
  def test_manage_rss_type_content
    get :manage_rss_type_content
    assert_response :success
    assert_not_nil assigns(:rss_contents)
    assert_not_nil assigns(:rss_types)
    @rss_type=assigns(:rss_types)
    @rss_content=assigns(:rss_contents)
  end
  
  
end
