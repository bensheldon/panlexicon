class AddWordCountToGroups < ActiveRecord::Migration[5.0]
  def change
    change_table :groups do |t|
      t.column :words_count, :integer, default: 0, null: false
    end

    reversible do |direction|
      direction.up do
        Group.find_each do |group|
          Group.reset_counters group.id, :words
        end
      end
    end
  end
end
