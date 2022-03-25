# frozen_string_literal: true

# == Schema Information
#
# Table name: search_records
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_search_records_on_created_at  (created_at)
#  index_search_records_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => nullify
#

class SearchRecord < ApplicationRecord
  STORAGE_LIFETIME = 180.days

  belongs_to :user, optional: true
  has_many :search_records_words, -> { order(position: :asc) }, inverse_of: :search_record # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :words, through: :search_records_words

  scope :lifetime_expired, -> { where(user: nil).where('created_at < ?', STORAGE_LIFETIME.ago) }

  def self.create_from_search(search, user: nil)
    searched_words = search.fragments.map do |fragment|
      {
        word: fragment.word,
        position: fragment.position,
        operation: fragment.operation,
      }
    end

    transaction do
      create(user: user).tap do |search_record|
        search_record.search_records_words.create(searched_words)
      end
    end
  end

  # Optimized for speed; will not call any after_* hooks
  def self.delete_expired
    transaction do
      lifetime_expired.delete_all
    end
  end
end
