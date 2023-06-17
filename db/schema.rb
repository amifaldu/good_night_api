# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_17_001920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sleep_records", comment: "Table for storing sleep records", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "User reference for the sleep record"
    t.datetime "sleep_start", comment: "Start time of sleep"
    t.datetime "sleep_end", comment: "End time of sleep"
    t.integer "sleep_duration", comment: "Duration of sleep in minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sleep_records_on_user_id"
  end

  create_table "user_followings", comment: "Table for storing user followings", force: :cascade do |t|
    t.bigint "follower_user_id", comment: "User who is following"
    t.bigint "following_user_id", comment: "User being followed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_user_id", "following_user_id"], name: "index_followings_on_user_id_and_following_user_id", unique: true, comment: "Index for unique user followings"
    t.index ["follower_user_id"], name: "index_user_followings_on_follower_user_id"
    t.index ["following_user_id"], name: "index_user_followings_on_following_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sleep_records", "users"
  add_foreign_key "user_followings", "users", column: "follower_user_id"
  add_foreign_key "user_followings", "users", column: "following_user_id"
end
