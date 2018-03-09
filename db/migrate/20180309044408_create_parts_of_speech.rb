class CreatePartsOfSpeech < ActiveRecord::Migration[5.1]
  def change
    create_table :parts_of_speech do |t|
      t.references :word, null: false
      t.string :type_code, null: false, limit: 1

      t.index [:word_id, :type_code], unique: true
    end
  end
end
