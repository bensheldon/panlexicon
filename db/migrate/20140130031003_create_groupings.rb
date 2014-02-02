class CreateGroupings < ActiveRecord::Migration
  def change
    create_join_table :groups, :terms, table_name: :groupings do |t|
      t.index :group_id
      t.index :term_id
    end
  end
end
