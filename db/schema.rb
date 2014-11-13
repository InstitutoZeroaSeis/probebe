# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141106185222) do

  create_table "article_references", force: true do |t|
    t.string   "source"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "type"
    t.string   "title"
    t.text     "text"
    t.text     "summary"
    t.integer  "gender",             default: 2
    t.integer  "category_id"
    t.boolean  "teenage_pregnancy"
    t.integer  "baby_target_type"
    t.integer  "minimum_valid_week"
    t.integer  "maximum_valid_week"
    t.integer  "user_id"
    t.integer  "parent_article_id"
    t.integer  "original_author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles_tags", id: false, force: true do |t|
    t.integer "article_id", null: false
    t.integer "tag_id",     null: false
  end

  create_table "avatars", force: true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "parent_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cell_phones", force: true do |t|
    t.string   "number"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "children", force: true do |t|
    t.string   "name"
    t.integer  "gender"
    t.date     "birth_date"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "message_deliveries", force: true do |t|
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_deliveries_profiles", id: false, force: true do |t|
    t.integer "message_delivery_id", null: false
    t.integer "profile_id",          null: false
  end

  create_table "messages", force: true do |t|
    t.text     "text"
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.date     "birth_date"
    t.integer  "gender",            default: 2
    t.integer  "user_id"
    t.string   "city"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "state"
    t.string   "street"
    t.string   "home_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
