# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_06_025421) do

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "style"
    t.string "access"
    t.integer "creator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "holes", force: :cascade do |t|
    t.integer "hole_number"
    t.integer "par"
    t.integer "yardage"
    t.integer "tee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tee_id"], name: "index_holes_on_tee_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "date"
    t.string "tee"
    t.integer "course_id", null: false
    t.integer "golfer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_rounds_on_course_id"
    t.index ["golfer_id"], name: "index_rounds_on_golfer_id"
  end

  create_table "scorecards", force: :cascade do |t|
    t.boolean "fairway"
    t.boolean "gir"
    t.integer "hole_number"
    t.text "notes"
    t.integer "putts"
    t.integer "strokes"
    t.integer "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_scorecards_on_round_id"
  end

  create_table "tees", force: :cascade do |t|
    t.string "color"
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_tees_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "holes", "tees"
  add_foreign_key "rounds", "courses"
  add_foreign_key "rounds", "golfers"
  add_foreign_key "scorecards", "rounds"
  add_foreign_key "tees", "courses"
end
