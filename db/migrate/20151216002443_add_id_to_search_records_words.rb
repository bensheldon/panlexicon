class AddIdToSearchRecordsWords < ActiveRecord::Migration
  def change
    add_column :search_records_words, :id, :primary_key
  end
end
