class CreateRssTypes < ActiveRecord::Migration
  def self.up
    create_table "rss_types", :force => true do |t|
    t.datetime "updated_at"
    t.text     "name"
    t.text     "rssfile"
    t.text     "desc"
  end
  
    
  end

  def self.down
    drop_table :rss_types
  end
end
