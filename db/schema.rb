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

ActiveRecord::Schema[7.0].define(version: 2022_09_01_233921) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "empty_migrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "good_job_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "state"
  end

  create_table "good_job_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "key"
    t.jsonb "value"
    t.index ["key"], name: "index_good_job_settings_on_key", unique: true
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "active_job_id"
    t.text "concurrency_key"
    t.text "cron_key"
    t.uuid "retried_good_job_id"
    t.datetime "cron_at"
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["active_job_id"], name: "index_good_jobs_on_active_job_id"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at"
    t.index ["cron_key", "cron_at"], name: "index_good_jobs_on_cron_key_and_cron_at", unique: true
    t.index ["finished_at"], name: "index_good_jobs_jobs_on_finished_at", where: "((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL))"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "groupings", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "word_id", null: false
    t.index ["group_id", "word_id"], name: "index_groupings_on_group_id_and_word_id", unique: true
    t.index ["word_id"], name: "index_groupings_on_word_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "key_word_id", null: false
    t.integer "words_count", default: 0, null: false
    t.index ["key_word_id"], name: "index_groups_on_key_word_id", unique: true
  end

  create_table "parts_of_speech", force: :cascade do |t|
    t.bigint "word_id", null: false
    t.string "type_code", limit: 1, null: false
    t.index ["word_id", "type_code"], name: "index_parts_of_speech_on_word_id_and_type_code", unique: true
    t.index ["word_id"], name: "index_parts_of_speech_on_word_id"
  end

  create_table "search_records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "user_id"
    t.index ["created_at"], name: "index_search_records_on_created_at"
    t.index ["user_id"], name: "index_search_records_on_user_id"
  end

  create_table "search_records_words", force: :cascade do |t|
    t.integer "search_record_id", null: false
    t.integer "word_id", null: false
    t.integer "position", null: false
    t.integer "operation", default: 0, null: false
    t.index ["search_record_id", "position"], name: "index_search_records_words_on_search_record_id_and_position", unique: true
    t.index ["search_record_id", "word_id"], name: "index_search_records_words_on_search_record_id_and_word_id", unique: true
    t.index ["word_id"], name: "index_search_records_words_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.citext "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "word_of_the_days", force: :cascade do |t|
    t.date "date", null: false
    t.integer "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_word_of_the_days_on_date", unique: true
    t.index ["word_id"], name: "index_word_of_the_days_on_word_id", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.citext "name", null: false
    t.integer "groups_count", default: 0, null: false
    t.integer "parts_of_speech_count", default: 0, null: false
    t.index ["name"], name: "index_words_on_name", unique: true
  end

  add_foreign_key "groupings", "groups"
  add_foreign_key "groupings", "words"
  add_foreign_key "groups", "words", column: "key_word_id"
  add_foreign_key "search_records", "users", on_delete: :nullify
  add_foreign_key "search_records_words", "search_records", on_delete: :cascade
  add_foreign_key "search_records_words", "words"
  add_foreign_key "word_of_the_days", "words"
end
