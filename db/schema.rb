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

ActiveRecord::Schema.define(version: 20160226234440) do

  create_table "mailing_list_subscriptions", id: false, force: :cascade do |t|
    t.integer  "mailing_list_id", null: false
    t.integer  "user_id",         null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "mailing_list_subscriptions", ["mailing_list_id", "user_id"], name: "all_unique", unique: true
  add_index "mailing_list_subscriptions", ["mailing_list_id"], name: "index_mailing_list_subscriptions_on_mailing_list_id"
  add_index "mailing_list_subscriptions", ["user_id"], name: "index_mailing_list_subscriptions_on_user_id"

  create_table "mailing_lists", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "email",                       null: false
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0, null: false
    t.date     "sq_start_date"
    t.date     "sq_end_date"
    t.string   "discipline"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
