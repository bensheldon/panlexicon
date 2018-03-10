# == Schema Information
#
# Table name: words
#
#  id                    :integer          not null, primary key
#  name                  :citext           not null
#  groups_count          :integer          default(0), not null
#  parts_of_speech_count :integer          default(0), not null
#
# Indexes
#
#  index_words_on_name  (name) UNIQUE
#

class Word < ApplicationRecord
  has_many :groupings
  has_many :groups, through: :groupings
  has_many :parts_of_speech
  has_many :search_records_words
  has_many :search_records, through: :search_records_words
end
