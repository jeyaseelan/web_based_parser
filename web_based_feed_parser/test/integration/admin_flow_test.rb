require File.dirname(__FILE__) + '/../test_helper'

class AdminFlowTest < ActionController::IntegrationTest
  fixtures :users
  def test_admin_flow
    https! 
    get '/login'  
    assert_response :success
    post_via_redirect '/login/authentication' , :user=>{:user_name=>"admin",:password=>"password"}
    assert_equal 'Admin', session[:role]
    assert_equal 'Administrator', session[:name]
    
    https!(false)  
    get "/admin/index"  
    assert_response :success
    assert_not_nil assigns(:rss_content)
    @rss_content = assigns(:rss_content)
    assert_instance_of RssContent, @rss_content, "It is not a Rss Content Record"
    
    get "/admin/manage_rss_type" 
    assert_response :success
    assert_not_nil assigns(:rss_types)
    @rss_types=assigns(:rss_types)
    assert_not_equal 0,@rss_types.length,"should not be same"
    
    get "/admin/new_edit_rss?id=2" 
    assert_response :success
    assert_not_nil assigns(:rss_type)
    @rss_type = assigns(:rss_type)
    assert_equal 'true', flash[:sucess]
    
    get "/admin/new_edit_rss_content?id=20&rss_type_id=5"
    assert_not_nil assigns(:rss_content)
    assert_not_nil assigns(:rss_type)
    @rss_type=assigns(:rss_type)
    @rss_content=assigns(:rss_content)
    assert_instance_of RssContent, @rss_content, "It is not a Rss Content Record"
    assert_instance_of RssType, @rss_type, "It is not a Rss Content Record"
    
  end
end
