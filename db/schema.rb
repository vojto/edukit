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

ActiveRecord::Schema.define(:version => 20090207152559) do

  create_table "exams", :force => true do |t|
    t.date    "when"
    t.integer "subject_id"
    t.text    "notes"
    t.integer "length"
    t.integer "length_done"
  end

  create_table "homeworks", :force => true do |t|
    t.date    "when"
    t.integer "subject_id"
    t.text    "notes"
    t.integer "length"
    t.integer "length_done"
  end

  create_table "lesson_prepares", :force => true do |t|
    t.integer "length_done"
    t.integer "subject_id"
    t.date    "date"
  end

  create_table "notes", :force => true do |t|
    t.integer  "subject_id"
    t.string   "description"
    t.float    "note"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "subject_lessons", :force => true do |t|
    t.integer  "day"
    t.integer  "lesson"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
  end

  create_table "subjects", :force => true do |t|
    t.text     "title"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time"
    t.string   "type"
    t.integer  "user_id"
    t.string   "color"
    t.float    "average"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "openid_url"
  end

end
