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

ActiveRecord::Schema.define(version: 20150428142736) do

  create_table "canned_meat_campaigns", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.integer  "template_id"
    t.string   "status",      default: "draft", null: false
    t.string   "subject",                       null: false
    t.text     "body"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "canned_meat_campaigns", ["list_id"], name: "index_canned_meat_campaigns_on_list_id"
  add_index "canned_meat_campaigns", ["name"], name: "index_canned_meat_campaigns_on_name", unique: true
  add_index "canned_meat_campaigns", ["template_id"], name: "index_canned_meat_campaigns_on_template_id"

  create_table "canned_meat_lists", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "canned_meat_lists", ["name"], name: "index_canned_meat_lists_on_name", unique: true

  create_table "canned_meat_subscriptions", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.integer  "list_id"
    t.datetime "unsubscribed_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "canned_meat_subscriptions", ["list_id"], name: "index_canned_meat_subscriptions_on_list_id"
  add_index "canned_meat_subscriptions", ["subscriber_type", "subscriber_id"], name: "index_canned_meat_subscriptions_on_subscriber_type_and_id"

  create_table "canned_meat_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "html"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "canned_meat_templates", ["name"], name: "index_canned_meat_templates_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
