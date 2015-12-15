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

ActiveRecord::Schema.define(version: 20151215194407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "groupings", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "word_id",  null: false
  end

  add_index "groupings", ["group_id", "word_id"], name: "index_groupings_on_group_id_and_word_id", unique: true, using: :btree
  add_index "groupings", ["word_id"], name: "index_groupings_on_word_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer "key_word_id", null: false
  end

  add_index "groups", ["key_word_id"], name: "index_groups_on_key_word_id", unique: true, using: :btree

  create_table "search_records", force: :cascade do |t|
    t.datetime "created_at", null: false
  end

  add_index "search_records", ["created_at"], name: "index_search_records_on_created_at", using: :btree

  create_table "search_records_words", id: false, force: :cascade do |t|
    t.integer "search_record_id",             null: false
    t.integer "word_id",                      null: false
    t.integer "position",                     null: false
    t.integer "operation",        default: 0, null: false
  end

  add_index "search_records_words", ["search_record_id", "position"], name: "index_search_records_words_on_search_record_id_and_position", unique: true, using: :btree
  add_index "search_records_words", ["search_record_id", "word_id"], name: "index_search_records_words_on_search_record_id_and_word_id", unique: true, using: :btree
  add_index "search_records_words", ["word_id"], name: "index_search_records_words_on_word_id", using: :btree

  create_table "word_of_the_days", force: :cascade do |t|
    t.date     "date",       null: false
    t.integer  "word_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "word_of_the_days", ["date"], name: "index_word_of_the_days_on_date", unique: true, using: :btree
  add_index "word_of_the_days", ["word_id"], name: "index_word_of_the_days_on_word_id", unique: true, using: :btree

  create_table "words", force: :cascade do |t|
    t.citext "name", null: false
  end

  add_index "words", ["name"], name: "index_words_on_name", unique: true, using: :btree

  add_foreign_key "groupings", "groups"
  add_foreign_key "groupings", "words"
  add_foreign_key "groups", "words", column: "key_word_id"
  add_foreign_key "search_records_words", "search_records"
  add_foreign_key "search_records_words", "words"
  add_foreign_key "word_of_the_days", "words"
end
