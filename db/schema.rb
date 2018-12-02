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

ActiveRecord::Schema.define(version: 2018_12_01_204639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
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

  create_table "departments", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedback_to_borrowers", force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "rate", null: false
    t.text "tag", array: true
    t.integer "credit", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedback_to_lenders", force: :cascade do |t|
    t.integer "request_id", null: false
    t.integer "rate", null: false
    t.text "tag", array: true
    t.integer "credit", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.text "owner", null: false
    t.text "status", default: "registered", null: false
    t.text "category_id", null: false
    t.text "condition", null: false
    t.text "rate_level"
    t.datetime "time_start", null: false
    t.datetime "time_end", null: false
    t.text "name", null: false
    t.text "photo_url"
    t.text "description", null: false
    t.text "brand"
    t.text "feature", array: true
    t.text "amazon_id"
    t.text "walmart_id"
    t.text "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.string "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.text "email", null: false
    t.text "first_name"
    t.text "middle_name"
    t.text "last_name"
    t.text "display_name", null: false
    t.text "phone_number"
    t.text "gender"
    t.text "language", null: false, array: true
    t.text "country", default: "Canada"
    t.text "facebook"
    t.text "google"
    t.text "wechat"
    t.text "twitter"
    t.text "avatar_url", null: false
    t.text "interest", array: true
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
