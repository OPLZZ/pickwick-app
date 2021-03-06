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

ActiveRecord::Schema.define(version: 20140410125835) do

  create_table "job_postings", force: true do |t|
    t.integer  "user_id",         limit: 5
    t.string   "checked",                   default: "not_checked"
    t.string   "api_id"
    t.string   "title"
    t.string   "employment_type"
    t.text     "description"
    t.text     "location"
    t.text     "compensation"
    t.text     "contact"
    t.text     "employer"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_postings", ["api_id"], name: "index_job_postings_on_api_id"
  add_index "job_postings", ["user_id"], name: "index_job_postings_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["system_id"], name: "index_users_on_system_id"
  add_index "users", ["token"], name: "index_users_on_token"

end
