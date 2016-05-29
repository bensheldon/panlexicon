# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :citext           not null
#  password_digest        :string
#  first_name             :string
#  last_name              :string
#  confirmation_digest    :string
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  reset_password_digest  :string
#  reset_password_sent_at :datetime
#  session_token          :string
#  is_admin               :boolean          default(FALSE), not null
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
  extend ActiveNull
  include SecureDigest

  # https://github.com/plataformatec/devise/blob/a2498074f19a047d422222e82257db15eaba9759/lib/devise.rb#L108
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  has_secure_password validations: false
  has_secure_token :session_token
  has_secure_digest :confirmation
  has_secure_digest :reset_password

  validates :email, presence: true,
    format: { with: EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, maximum: 80 }, allow_nil: true
end
