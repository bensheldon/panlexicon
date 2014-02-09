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

ActiveRecord::Schema.define(version: 20140130031003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groupings", id: false, force: true do |t|
    t.integer "group_id", null: false
    t.integer "word_id",  null: false
  end

  add_index "groupings", ["group_id"], name: "index_groupings_on_group_id", using: :btree
  add_index "groupings", ["word_id"], name: "index_groupings_on_word_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer "key_word_id", null: false
  end

  add_index "groups", ["key_word_id"], name: "index_groups_on_key_word_id", unique: true, using: :btree

  create_table "words", force: true do |t|
    t.string "name", null: false
  end

  add_index "words", ["name"], name: "index_words_on_name", unique: true, using: :btree

end
