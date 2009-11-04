class UserRssTypeRssContent < ActiveRecord::Base
  validates_presence_of :rss_type_id,:rss_content_id,:user_id
  validates_uniqueness_of :rss_content_id,:scope=>"user_id"
  belongs_to :user
  belongs_to :rss_type
  belongs_to :rss_content
end
