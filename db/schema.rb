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

ActiveRecord::Schema.define(version: 20140416175442) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "taken",      default: 0
    t.integer  "taught",     default: 0
    t.integer  "gh_stat",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level"
  end

  add_index "experiences", ["tag_id"], name: "index_experiences_on_tag_id"
  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id"

  create_table "lesson_tags", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lesson_tags", ["lesson_id"], name: "index_lesson_tags_on_lesson_id"
  add_index "lesson_tags", ["tag_id"], name: "index_lesson_tags_on_tag_id"

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "references"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "specific_time",     limit: 255
    t.string   "specific_location"
    t.string   "status",                        default: "open"
    t.string   "slug"
  end

  create_table "registrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      default: false
  end

  add_index "registrations", ["lesson_id"], name: "index_registrations_on_lesson_id"
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",   default: "topic"
    t.string   "slug"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "email"
    t.string   "image_url",  default: "http://i265.photobucket.com/albums/ii220/ivnovitch/pokeball.png"
    t.string   "token"
    t.string   "bio"
  end

end
