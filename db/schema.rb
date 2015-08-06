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

ActiveRecord::Schema.define(version: 20150806001754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "option_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "answers", ["option_id"], name: "index_answers_on_option_id", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string   "option"
    t.integer  "votes"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.boolean  "exclusive"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "limit"
    t.integer  "total_votes"
    t.boolean  "active"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  add_index "questions", ["category_id"], name: "index_questions_on_category_id", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "unlocked_questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "unlocked_questions", ["question_id"], name: "index_unlocked_questions_on_question_id", using: :btree
  add_index "unlocked_questions", ["user_id"], name: "index_unlocked_questions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "device_token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "answered_questions"
    t.integer  "questions_asked"
    t.integer  "my_questions_answers"
    t.integer  "credits"
    t.integer  "experience"
  end

  add_index "users", ["device_token"], name: "index_users_on_device_token", unique: true, using: :btree

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "questions", "categories"
  add_foreign_key "questions", "users"
  add_foreign_key "unlocked_questions", "questions"
  add_foreign_key "unlocked_questions", "users"
end
