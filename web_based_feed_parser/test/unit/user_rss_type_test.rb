require File.dirname(__FILE__) + '/../test_helper'

class UserRssTypeTest < ActiveSupport::TestCase
  fixtures :user_rss_types
  
  def test_user_rss_type
    new_user_rss_type=nil
    assert_nil new_user_rss_type ,"Contains some data. But should not"
    new_user_rss_type=UserRssType.new
    assert_not_nil new_user_rss_type ,"No data in it.But expected!"
    assert !new_user_rss_type.save,"User Rss Type record created with empty fields"
    initial_count=UserRssType.count
    new_user_rss_type=UserRssType.new(:user_id=>1,:rss_type_id=>2)
    assert new_user_rss_type.save ,"User Rss Type record was not created"
    present_count=UserRssType.count
    assert_equal initial_count+1,present_count,"New Record was not created"
    assert new_user_rss_type.destroy
    first_user_rss_type=user_rss_types(:user_rss_types_001)
    second_user_rss_type=user_rss_types(:user_rss_types_002)
    assert_instance_of UserRssType, first_user_rss_type, "It is not a user rss type record"
    first_user_rss_type.rss_type_id=second_user_rss_type.rss_type_id
    assert !first_user_rss_type.save ,"saved with duplicate rss type id for the same user"
    first_user_rss_type.destroy
    second_user_rss_type.destroy
    assert_equal 0,UserRssType.count,"Not all data deleted"
  end
  
end
