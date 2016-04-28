# == Schema Information
#
# Table name: search_records
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#
# Indexes
#
#  index_search_records_on_created_at  (created_at)
#

class SearchRecord < ActiveRecord::Base
  STORAGE_LIFETIME = 14.days

  has_many :search_records_words, dependent: :destroy
  has_many :words, -> { order('search_records_words.position') }, through: :search_records_words

  scope :lifetime_expired, -> { where 'created_at < ?', STORAGE_LIFETIME.ago }

  def self.create_from_search(search)
    search_record = create
    search.fragments.each do |fragment|
      search_record.search_records_words.create word: fragment.word,
        position: fragment.position,
        operation: fragment.operation
    end

    search_record
  end

  # Optimized for speed; will not call any after_* hooks
  def self.delete_expired
    transaction do
      sr_ids = lifetime_expired.pluck(:id)
      SearchRecordsWord.where(search_record_id: sr_ids).delete_all
      where(id: sr_ids).delete_all
    end
  end
end
