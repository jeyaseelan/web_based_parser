class CreateUserRssTypes < ActiveRecord::Migration
  def self.up
    create_table "user_rss_types", :force => true do |t|
    t.datetime "updated_at"
    t.integer  "user_id",                        :null => false
    t.integer  "rss_type_id",                    :null => false
    t.text     "open_type",   :default => "new"
  end
  end

  def self.down
    drop_table :user_rss_types
  end
end
