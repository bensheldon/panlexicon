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

ActiveRecord::Schema.define(version: 20180309044408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "groupings", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "word_id", null: false
    t.index ["group_id", "word_id"], name: "index_groupings_on_group_id_and_word_id", unique: true
    t.index ["word_id"], name: "index_groupings_on_word_id"
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.integer "key_word_id", null: false
    t.integer "words_count", default: 0, null: false
    t.index ["key_word_id"], name: "index_groups_on_key_word_id", unique: true
  end

  create_table "parts_of_speech", force: :cascade do |t|
    t.bigint "word_id"
    t.string "type"
    t.index ["word_id", "type"], name: "index_parts_of_speech_on_word_id_and_type", unique: true
    t.index ["word_id"], name: "index_parts_of_speech_on_word_id"
  end

  create_table "search_records", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "user_id"
    t.index ["created_at"], name: "index_search_records_on_created_at"
    t.index ["user_id"], name: "index_search_records_on_user_id"
  end

  create_table "search_records_words", force: :cascade do |t|
    t.bigint "search_record_id", null: false
    t.bigint "word_id", null: false
    t.integer "position", null: false
    t.integer "operation", default: 0, null: false
    t.index ["search_record_id", "position"], name: "index_search_records_words_on_search_record_id_and_position", unique: true
    t.index ["search_record_id", "word_id"], name: "index_search_records_words_on_search_record_id_and_word_id", unique: true
    t.index ["word_id"], name: "index_search_records_words_on_word_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.citext "email", null: false
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "confirmation_digest"
    t.datetime "confirmed_at"
    t.string "unconfirmed_email"
    t.string "reset_password_digest"
    t.datetime "reset_password_sent_at"
    t.string "session_token"
    t.boolean "is_admin", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "word_of_the_days", id: :serial, force: :cascade do |t|
    t.date "date", null: false
    t.integer "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_word_of_the_days_on_date", unique: true
    t.index ["word_id"], name: "index_word_of_the_days_on_word_id", unique: true
  end

  create_table "words", id: :serial, force: :cascade do |t|
    t.citext "name", null: false
    t.integer "groups_count", default: 0, null: false
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
