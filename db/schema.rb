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

ActiveRecord::Schema[7.1].define(version: 2024_07_22_163924) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "forms", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.date "date_of_birth"
    t.string "address"
    t.string "relationship"
    t.string "hobbies"
    t.integer "height"
    t.integer "weight"
    t.string "conditions"
    t.text "conditions_other"
    t.string "medication"
    t.boolean "hospital"
    t.string "services"
    t.text "services_other"
    t.date "start_date"
    t.date "end_date"
    t.string "languages"
    t.text "languages_other"
    t.text "mental_primary_assessment"
    t.text "physical_primary_assessment"
    t.text "environment_primary_assessment"
    t.text "mental_assessment"
    t.text "physical_assessment"
    t.text "environment_assessment"
    t.datetime "meet_date"
    t.string "nok_address"
    t.string "nok_contact_no"
    t.string "nok_first_name"
    t.string "nok_last_name"
    t.string "nok_email"
    t.string "nok_postal"
    t.string "postal"
    t.boolean "submitted"
    t.datetime "last_edit"
    t.datetime "last_viewed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "mental_transcription"
    t.boolean "autofill_address", default: true
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "location"
    t.datetime "start_time"
    t.integer "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_meetings_on_form_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_first_name"
    t.string "user_last_name"
    t.string "user_contact_number"
    t.string "user_address"
    t.string "user_postal"
    t.boolean "admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
