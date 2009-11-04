require File.dirname(__FILE__) + '/../test_helper'

class RssTypeTest < ActiveSupport::TestCase
  fixtures :rss_types
  
  
  def test_rss_type
    new_rss_type=nil
    assert_nil new_rss_type ,"Contains some data. But should not"
    new_rss_type=RssType.new
    assert_not_nil new_rss_type ,"No data in it.But expected!"
    assert !new_rss_type.save,"Rss Type record created with empty fields"
    initial_count=RssType.count
    new_rss_type=RssType.new(:name=>"sample_rss",:rssfile=>"rss_file",:desc=>"desc")
    assert new_rss_type.save ,"Rss Type record was not created"
    present_count=RssType.count
    assert_equal initial_count+1,present_count,"New Record was not created"
    assert new_rss_type.destroy
    first_rss_type=rss_types(:rss_types_002)
    second_rss_type=rss_types(:rss_types_003)
    assert_not_equal first_rss_type.name, second_rss_type.name, "Email ids should not be same"
    assert_not_equal first_rss_type.rssfile, second_rss_type.rssfile, "Mobile Number should not be same"
    
    assert_instance_of RssType, first_rss_type, "It is not a rss type record"
    first_rss_type.name=second_rss_type.name
    assert !first_rss_type.save ,"saved with duplicate rss names but should not"
    
    old_rss_content=RssContent.find(:all,:conditions=>["rss_type_id=#{first_rss_type.id}"])
    old_user_rss_type=UserRssType.find(:all,:conditions=>["rss_type_id=#{first_rss_type.id}"])
    old_user_rss_type_rss_content=UserRssTypeRssContent.find(:all,:conditions=>["rss_type_id=#{first_rss_type.id}"])
    
    old_rss_content.each do |rss_content|
      rss_content.destroy
    end 
    
    old_user_rss_type.each do |user_rss_type|
      user_rss_type.destroy
    end 
    
    old_user_rss_type_rss_content.each do |user_rss_type_content|
      user_rss_type_content.destroy
    end 
    
    new_rss_content=RssContent.find(:all,:conditions=>["rss_type_id=#{first_rss_type.id}"])
    new_user_rss_type=UserRssType.find(:all,:conditions=>["rss_type_id=#{first_rss_type.id}"])
    new_user_rss_type_rss_content=UserRssTypeRssContent.find(:all,:conditions=>["rss_type_id=#{first_rss_type.id}"])
    
    
    assert_not_equal old_rss_content.length,new_rss_content.length,"Should not be same"
    assert_not_equal old_user_rss_type.length,new_user_rss_type.length,"Should not be same"
    assert_not_equal old_user_rss_type_rss_content.length,new_user_rss_type_rss_content.length,"should not be same"
  end
  
end
