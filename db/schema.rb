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

ActiveRecord::Schema[7.1].define(version: 2025_05_15_042712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "islamic_values", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "letters", force: :cascade do |t|
    t.text "body"
    t.string "letter_type"
    t.bigint "mentor_id", null: false
    t.bigint "mentee_id", null: false
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id"], name: "index_letters_on_mentee_id"
    t.index ["mentor_id"], name: "index_letters_on_mentor_id"
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
    t.string "company"
    t.string "profession"
    t.string "status", default: "pending approval"
    t.index ["skill_id"], name: "index_menteeships_on_skill_id"
    t.index ["user_id"], name: "index_menteeships_on_user_id"
  end

  create_table "mentorships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company"
    t.string "profession"
    t.string "status", default: "pending approval"
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

  create_table "skill_slot_ideas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_slot_ideas_on_skill_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slot_bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "slot_id", null: false
    t.string "status"
    t.datetime "booking_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_id"], name: "index_slot_bookings_on_slot_id"
    t.index ["user_id", "slot_id"], name: "index_slot_bookings_on_user_id_and_slot_id", unique: true
    t.index ["user_id"], name: "index_slot_bookings_on_user_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meeting_offering_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "duration", default: 30
    t.string "title"
    t.integer "max_attendees"
    t.integer "min_attendees"
    t.string "timezone"
    t.bigint "mentorship_id"
    t.index ["meeting_offering_id"], name: "index_slots_on_meeting_offering_id"
    t.index ["mentorship_id"], name: "index_slots_on_mentorship_id"
    t.index ["user_id"], name: "index_slots_on_user_id"
  end

  create_table "sponsorship_interests", force: :cascade do |t|
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_phone"
    t.string "org_name"
    t.string "org_website"
    t.text "org_details"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "user_islamic_values", force: :cascade do |t|
    t.bigint "islamic_value_id", null: false
    t.bigint "user_id", null: false
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["islamic_value_id"], name: "index_user_islamic_values_on_islamic_value_id"
    t.index ["user_id"], name: "index_user_islamic_values_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "profession"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_cropped_url"
    t.string "avatar_source_url"
    t.string "company"
    t.string "status", default: "pending approval"
    t.string "type"
    t.string "preapproval_token", default: "false"
    t.string "linkedin_url"
    t.json "roles", default: []
    t.datetime "invite_letter_sent_at"
    t.datetime "converted_at"
    t.index ["email", "type"], name: "index_users_on_email_and_type", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "letters", "users", column: "mentee_id"
  add_foreign_key "letters", "users", column: "mentor_id"
  add_foreign_key "meeting_offerings", "mentorships"
  add_foreign_key "menteeships", "skills"
  add_foreign_key "menteeships", "users"
  add_foreign_key "mentorships", "skills"
  add_foreign_key "mentorships", "users"
  add_foreign_key "proofs", "menteeships"
  add_foreign_key "proofs", "mentorships"
  add_foreign_key "skill_slot_ideas", "skills"
  add_foreign_key "slot_bookings", "slots"
  add_foreign_key "slot_bookings", "users"
  add_foreign_key "slots", "meeting_offerings"
  add_foreign_key "slots", "mentorships"
  add_foreign_key "slots", "users"
  add_foreign_key "user_availabilities", "users"
  add_foreign_key "user_islamic_values", "islamic_values"
  add_foreign_key "user_islamic_values", "users"
end
