class CreatePartsOfSpeech < ActiveRecord::Migration[5.1]
  def change
    create_table :parts_of_speech do |t|
      t.references :word
      t.string :type

      t.index [:word_id, :type], unique: true
    end
  end
end
