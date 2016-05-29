class AddUserToSearchRecords < ActiveRecord::Migration[5.0]
  def change
    change_table :search_records do |t|
      t.references :user, index: true, foreign_key: { on_delete: :nullify }
    end
  end
end
