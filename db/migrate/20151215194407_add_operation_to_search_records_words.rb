class AddOperationToSearchRecordsWords < ActiveRecord::Migration
  def change
    add_column :search_records_words, :operation, :integer, default: 0, null: false
  end
end
