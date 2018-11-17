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

ActiveRecord::Schema.define(version: 2018_11_10_232429) do

  create_table "accounts", force: :cascade do |t|
    t.text "email", null: false
    t.text "role", null: false
    t.text "password", null: false
    t.text "salt", null: false
    t.text "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
  end

  create_table "addresses", force: :cascade do |t|
    t.text "email", null: false
    t.text "address_line1", null: false
    t.text "address_line2"
    t.text "city", null: false
    t.text "province", null: false
    t.text "country", null: false
    t.text "postal_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.text "department", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "request_id"
    t.integer "report_id"
    t.datetime "time", null: false
    t.text "sender", null: false
    t.text "receiver", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedback_to_borrowers", force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "rate", null: false
    t.text "tag"
    t.integer "credit", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedback_to_lenders", force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "rate", null: false
    t.text "tag"
    t.integer "credit", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id"
    t.text "owner", null: false
    t.text "condition", null: false
    t.text "rate_level"
    t.datetime "time_start", null: false
    t.datetime "time_end", null: false
    t.text "name", null: false
    t.text "photo_url"
    t.text "description", null: false
    t.text "brand"
    t.text "feature"
    t.text "amazon_id"
    t.text "walmart_id"
    t.text "isbn"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "profiles", id: false, force: :cascade do |t|
    t.text "email", null: false
    t.text "first_name"
    t.text "middle_name"
    t.text "last_name"
    t.text "display_name", null: false
    t.text "phone_number"
    t.text "gender"
    t.text "language", null: false
    t.text "country", default: "Canada"
    t.text "facebook"
    t.text "google"
    t.text "wechat"
    t.text "twitter"
    t.text "avatar_url", null: false
    t.text "interest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.text "report_type", null: false
    t.text "subject", null: false
    t.text "content", null: false
    t.text "status", null: false
    t.text "handler"
    t.datetime "time_submitted", null: false
    t.datetime "time_closed"
    t.integer "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "item_id", null: false
    t.text "borrower", null: false
    t.integer "address"
    t.text "status", default: "pending"
    t.text "rejected_reason"
    t.datetime "time_start", null: false
    t.datetime "time_end", null: false
    t.boolean "received", default: false, null: false
    t.boolean "returned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
