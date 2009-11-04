class RssContent < ActiveRecord::Base
  validates_presence_of :title,:description,:article
  belongs_to :rss_type 
  has_many :rss_type_contents
  def self.delete_rss_content(id)
    RssContent.delete(id)
    UserRssTypeRssContent.delete_all(:rss_content_id=>id)
  end
end
