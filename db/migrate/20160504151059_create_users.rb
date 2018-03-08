class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.citext :email, null: false
      t.string :password_digest

      t.string :first_name
      t.string :last_name

      t.string :confirmation_digest
      t.datetime :confirmed_at
      t.string :unconfirmed_email

      t.string :reset_password_digest
      t.datetime :reset_password_sent_at

      t.string :session_token

      t.boolean :is_admin, null: false, default: false

      t.timestamps

      t.index :email, unique: true
    end
  end
end
