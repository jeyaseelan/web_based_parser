class RssType < ActiveRecord::Base
  validates_presence_of :name,:rssfile,:desc
  validates_uniqueness_of :name
  validates_uniqueness_of :rssfile
  has_many :user_rss_types
  has_many :rss_contents
  def self.delete_rss_type(id)
    RssContent.delete_all(:rss_type_id=>id)
    UserRssTypeRssContent.delete_all(:rss_type_id=>id)
    UserRssType.delete_all(:rss_type_id=>id)
    RssType.delete(id)
  end
end
