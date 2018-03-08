class CreateGroupsWords < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'citext'

    create_table :words do |t|
      t.citext :name, null: false

      t.index :name, unique: true
    end

    create_table :groups do |t|
      t.integer :key_word_id, null: false

      t.index :key_word_id, unique: true
      t.foreign_key :words, column: :key_word_id
    end
  end
end
