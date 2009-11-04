require File.dirname(__FILE__) + '/../test_helper'

class RssContentTest < ActiveSupport::TestCase
  fixtures :rss_contents
  def test_rss_type
    new_rss_content=nil
    assert_nil new_rss_content ,"Contains some data. But should not"
    new_rss_content=RssContent.new
    assert_not_nil new_rss_content ,"No data in it.But expected!"
    assert !new_rss_content.save,"Rss  Content record created with empty fields"
    initial_count=RssContent.count
    new_rss_content=RssContent.new(:title=>"desc",:description=>"rss_file",:article=>"sample_rss",:rss_type_id=>1)
    assert new_rss_content.save ,"Rss  Content record was not created"
    present_count=RssContent.count
    assert_equal initial_count+1,present_count,"New Record was not created"
    assert new_rss_content.destroy
    first_rss_type_content=rss_contents(:rss_contents_002)
    second_rss_type_content=rss_contents(:rss_contents_003)
    assert_not_equal first_rss_type_content.id, second_rss_type_content.id, "ids should not be same"
    assert_instance_of RssContent, first_rss_type_content, "It is not a rss  Content record"
    old_rss_content=RssContent.find(:all,:conditions=>["id=#{first_rss_type_content.id}"])
    old_user_rss_type_rss_content=UserRssTypeRssContent.find(:all,:conditions=>["rss_content_id=#{first_rss_type_content.id}"])
    old_rss_content.each do |rss_content|
      rss_content.destroy
    end 
    old_user_rss_type_rss_content.each do |user_rss_type_content|
      user_rss_type_content.destroy
    end 
    new_rss_content=RssContent.find(:all,:conditions=>["id=#{first_rss_type_content.id}"])
    new_user_rss_type_rss_content=UserRssTypeRssContent.find(:all,:conditions=>["rss_content_id=#{first_rss_type_content.id}"])
    assert_not_equal old_rss_content.length,new_rss_content.length,"Should not be same"
  end
end
