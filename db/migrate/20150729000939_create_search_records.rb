class CreateSearchRecords < ActiveRecord::Migration
  def change
    create_table :search_records do |t|
      t.datetime :created_at, null: false

      t.index :created_at
    end

    create_join_table :search_records, :words do |t|
      t.integer :position, null: false

      t.index [:search_record_id, :word_id], unique: true
      t.index [:search_record_id, :position], unique: true
      t.index :word_id

      t.foreign_key :search_records
      t.foreign_key :words
    end
  end
end
