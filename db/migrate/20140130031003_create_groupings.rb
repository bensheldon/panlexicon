class CreateGroupings < ActiveRecord::Migration
  def change
    create_join_table :groups, :words, table_name: :groupings do |t|
      t.index [:group_id, :word_id], unique: true
      t.index :word_id

      t.foreign_key :words
      t.foreign_key :groups
    end
  end
end
