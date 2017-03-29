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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170328224530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "space_id"
    t.integer  "search_id"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "country"
    t.string   "postal_code"
    t.string   "province"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["search_id"], name: "index_addresses_on_search_id", using: :btree
    t.index ["space_id"], name: "index_addresses_on_space_id", using: :btree
    t.index ["user_id"], name: "index_addresses_on_user_id", using: :btree
  end

  create_table "chatrooms", force: :cascade do |t|
    t.integer  "shared_rental_id"
    t.string   "topic"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["shared_rental_id"], name: "index_chatrooms_on_shared_rental_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "space_id"
    t.string   "space_type"
    t.boolean  "active"
    t.string   "title"
    t.text     "description"
    t.text     "array_of_desired_times"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "country"
    t.string   "postal_code"
    t.string   "province"
    t.text     "address"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "city"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["space_id"], name: "index_searches_on_space_id", using: :btree
    t.index ["user_id"], name: "index_searches_on_user_id", using: :btree
  end

  create_table "shared_rentals", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spaces", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "type_of_space"
    t.text     "description"
    t.integer  "space_dimensions"
    t.integer  "space_capacity"
    t.boolean  "active"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "country"
    t.string   "postal_code"
    t.string   "province"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "city"
    t.boolean  "full_availability"
    t.text     "availability"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_spaces_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "country"
    t.string   "postal_code"
    t.string   "province"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "chatrooms", "shared_rentals"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
end
