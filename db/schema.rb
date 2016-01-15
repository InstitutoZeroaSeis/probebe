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

ActiveRecord::Schema.define(version: 20160114234503) do

  create_table "article_references", force: true do |t|
    t.string   "source"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.text     "summary"
    t.text     "box"
    t.integer  "gender",                         default: 2
    t.integer  "category_id"
    t.boolean  "teenage_pregnancy"
    t.integer  "baby_target_type"
    t.integer  "minimum_valid_week"
    t.integer  "maximum_valid_week"
    t.integer  "journalistic_articles_count",    default: 0,    null: false
    t.integer  "user_id"
    t.integer  "original_author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "publishable",                    default: true
    t.string   "image_cover"
    t.integer  "child_life_period"
    t.string   "intro_text"
    t.string   "thumb_image_cover_file_name"
    t.string   "thumb_image_cover_content_type"
    t.integer  "thumb_image_cover_file_size"
    t.datetime "thumb_image_cover_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "cover_picture_id"
    t.integer  "thumb_picture_id"
    t.string   "slug"
  end

  add_index "articles", ["cover_picture_id"], name: "index_articles_on_cover_picture_id", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree
  add_index "articles", ["thumb_picture_id"], name: "index_articles_on_thumb_picture_id", using: :btree

  create_table "articles_tags", id: false, force: true do |t|
    t.integer "article_id", null: false
    t.integer "tag_id",     null: false
  end

  create_table "authors", force: true do |t|
    t.string   "name"
    t.text     "bio"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", force: true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "child_id"
  end

  create_table "birthday_cards", force: true do |t|
    t.integer  "age"
    t.text     "text"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type",                default: 0
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_category_id"
    t.string   "color"
    t.integer  "original_category_type"
    t.string   "slug"
    t.string   "title"
    t.string   "subtitle"
    t.text     "text"
    t.text     "category_image_text"
    t.boolean  "show_in_home"
    t.string   "category_image_file_name"
    t.string   "category_image_content_type"
    t.integer  "category_image_file_size"
    t.datetime "category_image_updated_at"
    t.integer  "position_in_home"
    t.string   "second_color"
    t.integer  "picture_id"
    t.boolean  "blog_section",                default: false
  end

  add_index "categories", ["parent_category_id"], name: "index_categories_on_parent_category_id", using: :btree
  add_index "categories", ["picture_id"], name: "index_categories_on_picture_id", using: :btree

  create_table "children", force: true do |t|
    t.string   "name"
    t.integer  "gender",              default: 2
    t.date     "birth_date"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "born",                default: false
    t.integer  "donor_id"
    t.datetime "was_recipient_until"
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
    t.integer  "old_id"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "device_registrations", force: true do |t|
    t.string   "platform"
    t.string   "platform_code"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "endpoint_arn"
  end

  create_table "device_registrations_message_deliveries", id: false, force: true do |t|
    t.integer "device_registration_id", null: false
    t.integer "message_delivery_id",    null: false
  end

  create_table "donated_messages", force: true do |t|
    t.integer  "message_delivery_id"
    t.integer  "donor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donated_messages", ["message_delivery_id"], name: "index_donated_messages_on_message_delivery_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "message_deliveries", force: true do |t|
    t.integer  "message_id"
    t.integer  "child_id"
    t.date     "delivery_date"
    t.boolean  "message_for_test",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                        default: 0
    t.string   "cell_phone_number"
    t.boolean  "sms_allowed",                   default: false
    t.integer  "child_age_in_week_at_delivery"
    t.boolean  "mon_is_pregnat"
  end

  create_table "messages", force: true do |t|
    t.text     "text"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gender",             default: 2
    t.integer  "teenage_pregnancy"
    t.integer  "baby_target_type"
    t.integer  "minimum_valid_week"
    t.integer  "maximum_valid_week"
    t.integer  "category_id"
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.text     "text"
    t.integer  "logo_id"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "partners", ["slug"], name: "index_partners_on_slug", unique: true, using: :btree

  create_table "profiles", force: true do |t|
    t.date     "birth_date"
    t.integer  "gender",                         default: 2
    t.integer  "user_id"
    t.string   "city"
    t.string   "state"
    t.string   "street"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "address_complement"
    t.string   "postal_code"
    t.integer  "cell_phone_system",              default: 2
    t.string   "cell_phone"
    t.boolean  "authorized_receive_sms",         default: false
    t.integer  "profile_type",                   default: 0
    t.integer  "max_recipient_children",         default: 0
    t.boolean  "profile_completed_message_sent", default: false
    t.boolean  "allow_sms_message_sent",         default: false
    t.text     "message_days"
    t.string   "social_network_id"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "rpush_apps", force: true do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: true do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: true do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                              default: "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                             default: 86400
    t.boolean  "delivered",                          default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                             default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                      default: false
    t.string   "type",                                                   null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",                   default: false,     null: false
    t.text     "registration_ids",  limit: 16777215
    t.integer  "app_id",                                                 null: false
    t.integer  "retries",                            default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                         default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
  end

  add_index "rpush_notifications", ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi", using: :btree
  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", using: :btree

  create_table "site_banners", force: true do |t|
    t.integer  "position"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "name"
    t.integer  "picture_id"
  end

  add_index "site_banners", ["picture_id"], name: "index_site_banners_on_picture_id", using: :btree

  create_table "site_headers", force: true do |t|
    t.string   "path"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_landing_pages", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_mobile_images", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "text"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                    default: "",   null: false
    t.string   "encrypted_password",       default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "source"
    t.boolean  "change_omniauth_password", default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
