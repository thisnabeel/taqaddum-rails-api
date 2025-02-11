# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_11_154325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "islamic_values", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_offerings", force: :cascade do |t|
    t.string "title"
    t.bigint "mentorship_id", null: false
    t.text "description"
    t.integer "duration"
    t.integer "position"
    t.integer "max_attendees"
    t.integer "min_attendees"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentorship_id"], name: "index_meeting_offerings_on_mentorship_id"
  end

  create_table "menteeships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_menteeships_on_skill_id"
    t.index ["user_id"], name: "index_menteeships_on_user_id"
  end

  create_table "mentorships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_mentorships_on_skill_id"
    t.index ["user_id"], name: "index_mentorships_on_user_id"
  end

  create_table "proofs", force: :cascade do |t|
    t.bigint "mentorship_id", null: false
    t.bigint "menteeship_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menteeship_id"], name: "index_proofs_on_menteeship_id"
    t.index ["mentorship_id"], name: "index_proofs_on_mentorship_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meeting_offering_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_offering_id"], name: "index_slots_on_meeting_offering_id"
    t.index ["user_id"], name: "index_slots_on_user_id"
  end

  create_table "user_availabilities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "day"
    t.time "start_time"
    t.time "end_time"
    t.string "timezone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_availabilities_on_user_id"
  end

