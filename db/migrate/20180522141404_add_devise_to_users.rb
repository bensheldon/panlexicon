# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.1]
  def self.up
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    change_table :users do |t|
      t.uuid :uuid, default: "gen_random_uuid()", null: false
      t.timestamps null: false

      ## Database authenticatable
      t.citext :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.citext   :unconfirmed_email # Only if using reconfirmable
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
