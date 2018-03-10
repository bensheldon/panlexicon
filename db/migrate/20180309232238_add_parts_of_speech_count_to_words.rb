class AddPartsOfSpeechCountToWords < ActiveRecord::Migration[5.1]
  def change
    change_table :words do |t|
      t.column :parts_of_speech_count, :integer, default: 0, null: false
    end
  end
end
