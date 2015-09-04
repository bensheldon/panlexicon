class CreateWordOfTheDays < ActiveRecord::Migration
  def change
    create_table :word_of_the_days do |t|
      t.date :date, null: false
      t.references :word, null: false, foreign_key: true
      t.timestamps null: false

      t.index :date, unique: true
      t.index :word_id, unique: true
    end
  end
end
