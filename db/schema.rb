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

ActiveRecord::Schema.define(version: 20150228083819) do

  create_table "comments", force: true do |t|
    t.text     "content"
    t.text     "name"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["name"], name: "index_comments_on_name"
  add_index "comments", ["post_id", "created_at"], name: "index_comments_on_post_id_and_created_at"
  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "dares", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "user_id"
    t.integer  "bet"
    t.text     "body"
    t.integer  "won_id"
    t.integer  "lost_id"
    t.integer  "issued_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "accepted",     default: false
  end

  add_index "dares", ["issued_id"], name: "index_dares_on_issued_id"
  add_index "dares", ["lost_id"], name: "index_dares_on_lost_id"
  add_index "dares", ["recipient_id", "created_at"], name: "index_dares_on_recipient_id_and_created_at"
  add_index "dares", ["sender_id", "created_at"], name: "index_dares_on_sender_id_and_created_at"
  add_index "dares", ["user_id"], name: "index_dares_on_user_id"
  add_index "dares", ["won_id"], name: "index_dares_on_won_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "points", force: true do |t|
    t.integer  "user_id"
    t.integer  "bet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "points", ["user_id"], name: "index_points_on_user_id"

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "points_count",    default: 0
    t.integer  "posts_count",     default: 0
    t.integer  "bet"
    t.integer  "position"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["position"], name: "index_users_on_position"

  create_table "videos", force: true do |t|
    t.integer  "user_id"
    t.integer  "dare_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "videos", ["dare_id", "created_at"], name: "index_videos_on_dare_id_and_created_at"
  add_index "videos", ["dare_id"], name: "index_videos_on_dare_id"
  add_index "videos", ["user_id", "created_at"], name: "index_videos_on_user_id_and_created_at"
  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "dare_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["dare_id"], name: "index_votes_on_dare_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
