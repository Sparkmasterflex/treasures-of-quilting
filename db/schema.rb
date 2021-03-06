# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110522013719) do

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     :default => 0, :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "caption"
    t.boolean  "enabled",                 :default => false, :null => false
    t.integer  "position",                :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subpages", :force => true do |t|
    t.integer  "webpage_id"
    t.string   "parent"
    t.string   "page_alias"
    t.integer  "template",     :default => 20,   :null => false
    t.string   "page_title"
    t.text     "text"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preview_text"
    t.boolean  "enabled",      :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                         :null => false
    t.string   "last_name",                          :null => false
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "role",                :default => 0, :null => false
  end

  create_table "webpages", :force => true do |t|
    t.string   "page_alias"
    t.integer  "template",     :default => 20,    :null => false
    t.string   "page_title"
    t.text     "text"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_root",      :default => false, :null => false
    t.text     "preview_text"
    t.boolean  "enabled",      :default => true,  :null => false
  end

  create_table "widgets", :force => true do |t|
    t.integer  "gadget_id",                      :null => false
    t.string   "gadget_type",                    :null => false
    t.integer  "widget",                         :null => false
    t.text     "content"
    t.boolean  "enabled",     :default => false, :null => false
    t.integer  "position",    :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
