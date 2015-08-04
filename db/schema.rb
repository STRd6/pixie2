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

ActiveRecord::Schema.define(version: 20150804140412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type",       limit: 30
    t.string   "key",        limit: 255
    t.string   "token",      limit: 1024
    t.string   "secret",     limit: 255
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], name: "index_access_tokens_on_key", unique: true, using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "archived_sprites", id: false, force: :cascade do |t|
    t.integer  "id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
    t.integer  "frames"
    t.integer  "user_id"
    t.string   "title",              limit: 255
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "comments_count"
    t.datetime "deleted_at"
    t.boolean  "replayable",                     default: false, null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chats", ["created_at"], name: "index_chats_on_created_at", using: :btree

  create_table "collection_items", force: :cascade do |t|
    t.integer  "collection_id",             null: false
    t.integer  "item_id",                   null: false
    t.string   "item_type",     limit: 255, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "collection_items", ["collection_id"], name: "index_collection_items_on_collection_id", using: :btree
  add_index "collection_items", ["item_id", "item_type"], name: "index_collection_items_on_item_id_and_item_type", using: :btree

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id",                                null: false
    t.string   "name",           limit: 255,             null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "comments_count",             default: 0, null: false
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commenter_id",                 null: false
    t.integer  "commentable_id",               null: false
    t.string   "commentable_type", limit: 255, null: false
    t.text     "body",                         null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "commentee_id"
    t.integer  "root_id"
    t.integer  "in_reply_to_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["commentee_id"], name: "index_comments_on_commentee_id", using: :btree
  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "emails", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email",         limit: 255,                 null: false
    t.boolean  "undeliverable",             default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "emails", ["email"], name: "index_emails_on_email", using: :btree
  add_index "emails", ["user_id"], name: "index_emails_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "user_id"
    t.string   "session_id", limit: 32
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "events", ["name", "session_id"], name: "index_events_on_name_and_session_id", using: :btree
  add_index "events", ["name", "user_id", "session_id"], name: "index_events_on_name_and_user_id_and_session_id", using: :btree
  add_index "events", ["name", "user_id"], name: "index_events_on_name_and_user_id", using: :btree

  create_table "experiments", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "ended_at"
  end

  add_index "experiments", ["name"], name: "index_experiments_on_name", unique: true, using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body",                      null: false
    t.string   "email_address", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "followee_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["followee_id"], name: "index_follows_on_followee_id", using: :btree
  add_index "follows", ["follower_id", "followee_id"], name: "index_follows_on_follower_id_and_followee_id", unique: true, using: :btree
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "email",      limit: 255, null: false
    t.string   "token",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "to",         limit: 255, null: false
  end

  create_table "js_errors", force: :cascade do |t|
    t.string   "url",         limit: 255, null: false
    t.integer  "line_number",             null: false
    t.text     "message",                 null: false
    t.text     "user_agent",              null: false
    t.integer  "user_id"
    t.string   "session_id",  limit: 32
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string   "product",    limit: 255, null: false
    t.string   "email",      limit: 255, null: false
    t.string   "data",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "library_scripts", force: :cascade do |t|
    t.integer  "library_id", null: false
    t.integer  "script_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "library_scripts", ["library_id", "script_id"], name: "index_library_scripts_on_library_id_and_script_id", unique: true, using: :btree
  add_index "library_scripts", ["library_id"], name: "index_library_scripts_on_library_id", using: :btree
  add_index "library_scripts", ["script_id"], name: "index_library_scripts_on_script_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "target_id",               null: false
    t.string   "target_type", limit: 255, null: false
    t.string   "token",       limit: 16,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "links", ["token"], name: "index_links_on_token", unique: true, using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id",               null: false
    t.string   "group_type", limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "memberships", ["group_id", "group_type", "user_id"], name: "index_memberships_on_group_id_and_group_type_and_user_id", unique: true, using: :btree
  add_index "memberships", ["group_id", "group_type"], name: "index_memberships_on_group_id_and_group_type", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "oauth_tokens", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "provider",   limit: 255, null: false
    t.string   "token",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "oauth_tokens", ["user_id"], name: "index_oauth_tokens_on_user_id", using: :btree

  create_table "plugins", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "approved",                default: false, null: false
    t.string   "plugin_type", limit: 255,                 null: false
    t.string   "title",       limit: 255,                 null: false
    t.text     "description"
    t.text     "code",                                    null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "parent_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id",                                                        null: false
    t.string   "remote_origin",      limit: 255
    t.string   "title",              limit: 255,                                 null: false
    t.text     "description"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "url",                limit: 255
    t.boolean  "demo",                           default: false,                 null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "parent_id"
    t.integer  "comments_count",                 default: 0,                     null: false
    t.integer  "views_count",                    default: 0,                     null: false
    t.boolean  "tutorial",                       default: false,                 null: false
    t.boolean  "featured",                       default: false,                 null: false
    t.boolean  "arcade",                         default: false,                 null: false
    t.integer  "memberships_count",              default: 0,                     null: false
    t.datetime "saved_at",                       default: '2012-04-08 07:00:00', null: false
  end

  add_index "projects", ["url"], name: "index_projects_on_url", using: :btree

  create_table "script_members", force: :cascade do |t|
    t.integer  "script_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "script_members", ["script_id", "user_id"], name: "index_script_members_on_script_id_and_user_id", unique: true, using: :btree
  add_index "script_members", ["script_id"], name: "index_script_members_on_script_id", using: :btree
  add_index "script_members", ["user_id"], name: "index_script_members_on_user_id", using: :btree

  create_table "sounds", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.string   "wav_file_name",      limit: 255
    t.string   "wav_content_type",   limit: 255
    t.integer  "wav_file_size"
    t.datetime "wav_uploaded_at"
    t.string   "sfs_file_name",      limit: 255
    t.string   "sfs_content_type",   limit: 255
    t.integer  "sfs_file_size"
    t.datetime "sfs_uploaded_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "mp3_file_name",      limit: 255
    t.string   "mp3_content_type",   limit: 255
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "sprites", force: :cascade do |t|
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "width",                                           null: false
    t.integer  "height",                                          null: false
    t.integer  "frames",                          default: 1,     null: false
    t.integer  "user_id"
    t.string   "title",               limit: 255
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "comments_count",                  default: 0,     null: false
    t.boolean  "replayable",                      default: false, null: false
    t.string   "image_file_name",     limit: 255
    t.string   "image_content_type",  limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "replay_file_name"
    t.string   "replay_content_type"
    t.integer  "replay_file_size"
    t.datetime "replay_updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",                    null: false
    t.integer  "taggable_id",               null: false
    t.string   "taggable_type", limit: 255, null: false
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 255, null: false
    t.datetime "created_at",                null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255,             null: false
    t.integer "taggings_count",             default: 0
  end

  create_table "treatments", force: :cascade do |t|
    t.integer  "experiment_id",            null: false
    t.integer  "user_id"
    t.string   "session_id",    limit: 32
    t.boolean  "control",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "treatments", ["experiment_id", "session_id"], name: "index_treatments_on_experiment_id_and_session_id", unique: true, using: :btree
  add_index "treatments", ["experiment_id", "user_id"], name: "index_treatments_on_experiment_id_and_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255
    t.string   "crypted_password",    limit: 255
    t.string   "password_salt",       limit: 255
    t.string   "persistence_token",   limit: 255,                                 null: false
    t.string   "single_access_token", limit: 255,                                 null: false
    t.string   "perishable_token",    limit: 255,                                 null: false
    t.integer  "login_count",                     default: 0,                     null: false
    t.integer  "failed_login_count",              default: 0,                     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",    limit: 255
    t.string   "last_login_ip",       limit: 255
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "display_name",        limit: 255
    t.integer  "referrer_id"
    t.string   "oauth_secret",        limit: 255
    t.integer  "active_token_id"
    t.boolean  "admin",                           default: false,                 null: false
    t.integer  "comments_count",                  default: 0,                     null: false
    t.text     "profile"
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "subscribed",                      default: true,                  null: false
    t.string   "favorite_color",      limit: 255
    t.boolean  "paying",                          default: false,                 null: false
    t.boolean  "forem_admin",                     default: false,                 null: false
    t.boolean  "forum_notifications",             default: true,                  null: false
    t.boolean  "site_notifications",              default: true,                  null: false
    t.boolean  "help_tips",                       default: true,                  null: false
    t.string   "spreedly_token",      limit: 255
    t.datetime "last_contacted",                  default: '2011-12-29 01:37:27', null: false
    t.datetime "last_surveyed",                   default: '2009-12-29 02:38:45', null: false
    t.integer  "followers_count",                 default: 0,                     null: false
    t.integer  "following_count",                 default: 0,                     null: false
  end

  add_index "users", ["display_name"], name: "index_users_on_display_name", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type", limit: 255
    t.integer  "user_id"
    t.string   "user_type",      limit: 255
    t.string   "user_name",      limit: 255
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at", using: :btree
  add_index "versions", ["number"], name: "index_versions_on_number", using: :btree
  add_index "versions", ["tag"], name: "index_versions_on_tag", using: :btree
  add_index "versions", ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type", using: :btree
  add_index "versions", ["user_name"], name: "index_versions_on_user_name", using: :btree
  add_index "versions", ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type", using: :btree

  create_table "visits", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "controller", limit: 255, null: false
    t.string   "action",     limit: 255, null: false
    t.datetime "created_at",             null: false
    t.string   "session_id", limit: 32
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

end
