class CreateUsers < ActiveRecord::Migration
  def self.up
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

  def self.down
    drop_table :users
  end
end
