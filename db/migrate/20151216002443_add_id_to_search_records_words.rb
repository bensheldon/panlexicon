class AddIdToSearchRecordsWords < ActiveRecord::Migration[4.2]
  def change
    add_column :search_records_words, :id, :primary_key
  end
end
