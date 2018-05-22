# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  uuid                   :uuid             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :citext
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, #trackable, and :omniauthable
  devise :database_authenticatable, :confirmable, # :registerable,
         :recoverable, :rememberable, :validatable
  extend ActiveNull

  def is_admin?
    false
  end
end
