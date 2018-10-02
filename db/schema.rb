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

ActiveRecord::Schema.define(version: 20160527201653) do

  create_table "bnndlsts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "add_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bnndlsts", ["movie_id"], name: "index_bnndlsts_on_movie_id"
  add_index "bnndlsts", ["user_id"], name: "index_bnndlsts_on_user_id"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "movies", force: :cascade do |t|
    t.string   "name"
    t.string   "year"
    t.string   "imdb"
    t.text     "genres"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "cover_image"
    t.integer  "mood_fast",           default: 50
    t.integer  "mood_imaginary",      default: 50
    t.integer  "mood_colored",        default: 50
    t.integer  "mood_comedy",         default: 50
    t.integer  "mood_intelligent",    default: 50
    t.integer  "mood_ambient",        default: 50
    t.integer  "mood_diverse",        default: 50
    t.integer  "mood_wibbly",         default: 50
    t.integer  "mood_talky",          default: 50
    t.integer  "mood_known",          default: 50
    t.integer  "mood_characteristic", default: 50
    t.integer  "env_group",           default: 0
    t.integer  "env_theater",         default: 0
    t.integer  "env_consume",         default: 0
    t.integer  "personal_age",        default: 27
    t.integer  "personal_gender",     default: 50
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "title_votes", force: :cascade do |t|
    t.string   "commenter"
    t.integer  "vote"
    t.integer  "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "title_votes", ["movie_id"], name: "index_title_votes_on_movie_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "password_digest"
    t.integer  "score"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "remember_digest"
    t.boolean  "admin",                   default: false
    t.string   "activation_digest"
    t.boolean  "activated",               default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "fav_mood_fast",           default: 50
    t.integer  "fav_mood_imaginary",      default: 50
    t.integer  "fav_mood_colored",        default: 50
    t.integer  "fav_mood_comedy",         default: 50
    t.integer  "fav_mood_intelligent",    default: 50
    t.integer  "fav_mood_ambient",        default: 50
    t.integer  "fav_mood_diverse",        default: 50
    t.integer  "fav_mood_wibbly",         default: 50
    t.integer  "fav_mood_talky",          default: 50
    t.integer  "fav_mood_known",          default: 50
    t.integer  "fav_mood_characteristic", default: 50
    t.integer  "fav_env_group",           default: 0
    t.integer  "fav_env_theater",         default: 0
    t.integer  "fav_env_consume",         default: 0
    t.datetime "birthdate"
    t.boolean  "gender",                  default: true
    t.string   "fav_tags"
  end

  add_index "users", ["mail"], name: "index_users_on_mail", unique: true

  create_table "watcheds", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.datetime "add_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wishlsts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "add_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wishlsts", ["movie_id"], name: "index_wishlsts_on_movie_id"
  add_index "wishlsts", ["user_id"], name: "index_wishlsts_on_user_id"

end
