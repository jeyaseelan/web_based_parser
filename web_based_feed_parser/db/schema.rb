# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091030091408) do

  create_table "rss_contents", :force => true do |t|
    t.datetime "updated_at"
    t.datetime "posted_at"
    t.text     "title"
    t.text     "description"
    t.integer  "rss_type_id",                     :null => false
    t.text     "article"
    t.boolean  "select_status", :default => true
  end

  create_table "rss_types", :force => true do |t|
    t.datetime "updated_at"
    t.text     "name"
    t.text     "rssfile"
    t.text     "desc"
  end

  create_table "user_rss_type_rss_contents", :force => true do |t|
    t.datetime "updated_at"
    t.integer  "user_id",                           :null => false
    t.integer  "rss_type_id"
    t.integer  "rss_content_id",                    :null => false
    t.boolean  "viewed",         :default => false
  end

  create_table "user_rss_types", :force => true do |t|
    t.datetime "updated_at"
    t.integer  "user_id",                        :null => false
    t.integer  "rss_type_id",                    :null => false
    t.text     "open_type",   :default => "new"
  end

  create_table "users", :force => true do |t|
    t.datetime "updated_at"
    t.text     "name"
    t.text     "mobile"
    t.text     "email"
    t.text     "user_name"
    t.text     "salt"
    t.text     "encrypt_password"
    t.boolean  "admin",            :default => false
  end

end
