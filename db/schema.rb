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

ActiveRecord::Schema[7.0].define(version: 2021_09_11_181216) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.string "location"
    t.bigint "user_id"
    t.bigint "participant_id"
    t.bigint "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_attendances_on_participant_id"
    t.index ["reservation_id"], name: "index_attendances_on_reservation_id"
    t.index ["user_id", "participant_id", "reservation_id"], name: "index_unique_attendance_per_reservation", unique: true
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_name", null: false
    t.string "event_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_name"], name: "index_events_on_event_name", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.string "fullname"
    t.string "email", null: false
    t.string "ip_addr", null: false
    t.string "login_token", null: false
    t.datetime "token_valid_until", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_participants_on_email", unique: true
    t.index ["login_token"], name: "index_participants_on_login_token", unique: true
  end

  create_table "repeat_bookings", force: :cascade do |t|
    t.integer "repeat_every", null: false
    t.string "repeat_unit", null: false
    t.string "repeat_ordinal", null: false
    t.string "repeat_choice", null: false
    t.date "repeat_until_date", null: false
    t.string "host_name"
    t.text "alert_notice"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "start_date_time", precision: nil, null: false
    t.datetime "end_date_time", precision: nil, null: false
    t.boolean "is_cancelled", default: false, null: false
    t.bigint "event_id", null: false
    t.bigint "space_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_repeat_bookings_on_event_id"
    t.index ["space_id"], name: "index_repeat_bookings_on_space_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "host_name"
    t.text "alert_notice"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "start_date_time", precision: nil, null: false
    t.datetime "end_date_time", precision: nil, null: false
    t.boolean "is_cancelled", default: false, null: false
    t.bigint "event_id", null: false
    t.bigint "space_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "repeat_booking_id"
    t.text "remote_link"
    t.index ["end_date"], name: "index_reservations_on_end_date"
    t.index ["event_id", "space_id", "start_date_time", "end_date_time"], name: "index_reservation_unique", unique: true
    t.index ["event_id"], name: "index_reservations_on_event_id"
    t.index ["repeat_booking_id"], name: "index_reservations_on_repeat_booking_id"
    t.index ["space_id"], name: "index_reservations_on_space_id"
    t.index ["start_date"], name: "index_reservations_on_start_date"
  end

  create_table "spaces", force: :cascade do |t|
    t.string "space_name", null: false
    t.text "space_location"
    t.boolean "publicly_visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "onsite_limit", default: 6, null: false
    t.index ["space_name"], name: "index_spaces_on_space_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "real_name", null: false
    t.string "username", null: false
    t.string "access_role", default: "viewer", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "attendances", "participants"
  add_foreign_key "attendances", "reservations"
  add_foreign_key "attendances", "users"
  add_foreign_key "repeat_bookings", "events"
  add_foreign_key "repeat_bookings", "spaces"
  add_foreign_key "reservations", "events"
  add_foreign_key "reservations", "repeat_bookings"
  add_foreign_key "reservations", "spaces"
end
