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

ActiveRecord::Schema.define(version: 2020_10_27_083641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "event_name", null: false
    t.string "event_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repeat_bookings", force: :cascade do |t|
    t.json "settings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "host_name"
    t.text "alert_notice"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.datetime "start_date_time", null: false
    t.datetime "end_date_time", null: false
    t.boolean "is_cancelled", default: false, null: false
    t.bigint "event_id", null: false
    t.bigint "space_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "repeat_uuid_key"
    t.bigint "repeat_booking_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["space_name"], name: "index_spaces_on_space_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "real_name", null: false
    t.string "username", null: false
    t.string "access_role", default: "member", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "reservations", "events"
  add_foreign_key "reservations", "repeat_bookings"
  add_foreign_key "reservations", "spaces"
end
