class RemoveUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove :email
      t.remove :password_digest
      t.remove :first_name
      t.remove :last_name
      t.remove :confirmation_digest
      t.remove :confirmed_at
      t.remove :unconfirmed_email
      t.remove :reset_password_digest
      t.remove :reset_password_sent_at
      t.remove :session_token
      t.remove :is_admin
      t.remove :created_at
      t.remove :updated_at
    end
  end
end
