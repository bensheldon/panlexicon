class AddGroupCountToWords < ActiveRecord::Migration[5.0]
  def change
    change_table :words do |t|
      t.column :groups_count, :integer, default: 0, null: false
    end

    reversible do |direction|
      direction.up do
        Word.find_each do |word|
          Word.reset_counters word.id, :groups
        end
      end
    end
  end
end
