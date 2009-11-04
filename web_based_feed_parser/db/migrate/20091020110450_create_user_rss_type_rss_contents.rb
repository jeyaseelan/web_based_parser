class CreateUserRssTypeRssContents < ActiveRecord::Migration
  def self.up
    create_table "user_rss_type_rss_contents", :force => true do |t|
      t.datetime "updated_at"
      t.integer  "user_id",                    :null => false
      t.integer  "rss_type_id"
      t.integer  "rss_content_id",                      :null => false
      t.boolean  "viewed",           :default => false
    end
  end
  
  def self.down
    drop_table :user_rss_type_rss_contents
  end
end
