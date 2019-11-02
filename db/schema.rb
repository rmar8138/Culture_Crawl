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

ActiveRecord::Schema.define(version: 2019_10_31_043041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crawls", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.text "description"
    t.integer "price"
    t.integer "rating"
    t.integer "max_attendees"
    t.date "crawl_date"
    t.time "crawl_time"
    t.boolean "finished"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_crawls_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "crawl_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.index ["crawl_id"], name: "index_locations_on_crawl_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.text "bio"
    t.integer "rating"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "crawls", "users"
  add_foreign_key "locations", "crawls", on_delete: :cascade
  add_foreign_key "profiles", "users"
end
