require File.dirname(__FILE__) + '/../test_helper'
class UserRssTypeRssContentTest < ActiveSupport::TestCase
  fixtures :user_rss_type_rss_contents
  
  def test_user_rss_type
    new_user_rss_type_rss_content=nil
    assert_nil new_user_rss_type_rss_content ,"Contains some data. But should not"
    new_user_rss_type_rss_content=UserRssTypeRssContent.new
    assert_not_nil new_user_rss_type_rss_content ,"No data in it.But expected!"
    assert !new_user_rss_type_rss_content.save,"User Rss Type Rss Content record created with empty fields"
    initial_count=UserRssTypeRssContent.count
    new_user_rss_type_rss_content=UserRssTypeRssContent.new(:user_id=>1,:rss_type_id=>2,:rss_content_id=>2)
    assert new_user_rss_type_rss_content.save ,"User Rss Type Rss Content record was not created"
    present_count=UserRssTypeRssContent.count
    assert_equal initial_count+1,present_count,"New Record was not created"
    assert new_user_rss_type_rss_content.destroy
    first_user_rss_type_content=user_rss_type_rss_contents(:user_rss_type_rss_contents_001)
    assert_instance_of UserRssTypeRssContent, first_user_rss_type_content, "It is not a user rss type Rss Content record"
  end
end
