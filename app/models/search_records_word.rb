# == Schema Information
#
# Table name: search_records_words
#
#  search_record_id :integer          not null
#  word_id          :integer          not null
#  position         :integer          not null
#
# Indexes
#
#  index_search_records_words_on_search_record_id_and_position  (search_record_id,position) UNIQUE
#  index_search_records_words_on_search_record_id_and_word_id   (search_record_id,word_id) UNIQUE
#  index_search_records_words_on_word_id                        (word_id)
#

class SearchRecordsWord < ActiveRecord::Base
  belongs_to :search_record
  belongs_to :word
end
