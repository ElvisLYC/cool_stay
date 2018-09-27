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

ActiveRecord::Schema.define(version: 2018_09_26_082401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.string "uid"
    t.string "token"
    t.string "provider"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "property_title"
    t.string "location", null: false
    t.string "price", null: false
    t.string "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verify", default: false
    t.json "photos"
    t.string "property_type"
    t.integer "room_number"
    t.integer "bed_number"
    t.integer "guest_number"
    t.string "country"
    t.string "state"
    t.string "city"
    t.integer "zipcode"
    t.string "address"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "listing_id"
    t.integer "total_price"
    t.boolean "payment_status", default: false
    t.index ["listing_id"], name: "index_reservations_on_listing_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.integer "role", default: 0
    t.string "avatar"
    t.string "gender"
    t.integer "phone"
    t.string "country"
    t.date "birthdate"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "listings", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users"
end
