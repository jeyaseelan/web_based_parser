require File.dirname(__FILE__) + '/../test_helper'

class UserFlowTest < ActionController::IntegrationTest
  fixtures :users
  
  def test_user_flow
    https! 
    get '/login'  
    assert_response :success
    post_via_redirect '/login/authentication' , :user=>{:user_name=>"user",:password=>"password"}
    assert_equal 'User', session[:role]
    assert_equal 'User', session[:name]
    
    https!(false)  
    get "/user/index"  
    assert_response :success
    assert_not_nil assigns(:user_rss_types)
    assert_not_nil assigns(:rss_types)
    
    get "/user/add_type"  
    assert_response :success
    assert_not_nil assigns(:rss_types)
    @user_rss_types=assigns(:user_rss_types)
    assert_not_equal 0,@user_rss_types.length,"should not be same"
    @rss_types=assigns(:rss_types)
    assert_not_equal 0,@rss_types.length,"should not be same"
    
    get "/user/sub_index?delete_id=2"  
    assert_response :success
    assert_not_nil assigns(:user_rss_types)
    assert_not_nil assigns(:rss_types)
    
    
    get "/user/view_article?id=3"  
    assert_not_nil assigns(:rss_content)
    @rss_content = assigns(:rss_content)
    assert_instance_of RssContent, @rss_content, "It is not a Rss Content Record"
    
  end
end
