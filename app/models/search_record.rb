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
  has_many :search_records_words, dependent: :destroy
  has_many :words, -> { order('search_records_words.position') }, through: :search_records_words

  def self.create_from_search(search)
    search_record = create
    search.fragments.each do |fragment|
      search_record.search_records_words.create word: fragment.word,
        position: fragment.position,
        operation: fragment.operation
    end

    search_record
  end
end
