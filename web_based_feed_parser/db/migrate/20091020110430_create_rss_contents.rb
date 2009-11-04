class CreateRssContents < ActiveRecord::Migration
  def self.up
    create_table "rss_contents", :force => true do |t|
    t.datetime "updated_at"
    t.datetime "posted_at"
    t.text     "title"
    t.text     "description"
    t.integer  "rss_type_id",      :null => false
    t.text     "article"
    t.boolean  "select_status", :default => true
  end
     
   end

  def self.down
    drop_table :rss_contents
  end
end
