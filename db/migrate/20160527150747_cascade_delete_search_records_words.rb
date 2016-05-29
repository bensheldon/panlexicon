class CascadeDeleteSearchRecordsWords < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :search_records_words, :search_records
    add_foreign_key :search_records_words, :search_records, on_delete: :cascade
  end
end
