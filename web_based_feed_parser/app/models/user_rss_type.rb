class UserRssType < ActiveRecord::Base
  validates_presence_of :rss_type_id,:user_id
  validates_uniqueness_of :rss_type_id,:scope=>"user_id"
  belongs_to :user
  belongs_to :rss_type
end
