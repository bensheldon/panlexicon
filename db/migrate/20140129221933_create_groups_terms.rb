class CreateGroupsTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name, null: false
    end
    add_index :terms, :name, :unique => true

    create_table :groups do |t|
      t.integer :key_term_id, null: false
    end
    add_index :groups, :key_term_id, :unique => true
  end
end
    # create_join_table :terms, :groups,
    # add_index :groups_terms, [:term_id, :group_id], :unique => true
    # add_index :groups_terms, [:group_id, :term_id], :unique => true
