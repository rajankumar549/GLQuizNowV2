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

ActiveRecord::Schema.define(version: 2020_11_20_064227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leads", id: :integer, default: nil, force: :cascade do |t|
    t.string "name"
  end

  create_table "questions", force: :cascade do |t|
    t.string "statement"
    t.string "options", array: true
    t.string "correct"
    t.integer "weightage", default: 1
    t.string "tag", array: true
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "test_papers_id"
    t.bigint "users_id"
    t.integer "time_taken"
    t.string "status"
    t.integer "total"
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_papers_id"], name: "index_submissions_on_test_papers_id"
    t.index ["users_id"], name: "index_submissions_on_users_id"
  end

  create_table "test_papers", force: :cascade do |t|
    t.integer "time_allowed"
    t.string "test_details"
    t.bigint "questions_id", array: true
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questions_id"], name: "index_test_papers_on_questions_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.bigint "test_papers_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_papers_id"], name: "index_users_on_test_papers_id"
  end

  add_foreign_key "submissions", "test_papers", column: "test_papers_id"
  add_foreign_key "users", "test_papers", column: "test_papers_id"
end
