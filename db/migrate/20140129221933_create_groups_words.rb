class CreateGroupsWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name, null: false
    end
    add_index :words, :name, :unique => true

    create_table :groups do |t|
      t.integer :key_word_id, null: false
    end
    add_index :groups, :key_word_id, :unique => true
  end
end
    # create_join_table :words, :groups,
    # add_index :groups_words, [:word_id, :group_id], :unique => true
    # add_index :groups_words, [:group_id, :word_id], :unique => true
