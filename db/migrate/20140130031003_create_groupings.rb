class CreateGroupings < ActiveRecord::Migration
  def change
    create_join_table :groups, :words, table_name: :groupings do |t|
      t.index :group_id
      t.index :word_id
    end
  end
end
