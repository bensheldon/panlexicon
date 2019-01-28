# frozen_string_literal: true

# == Schema Information
#
# Table name: words
#
#  id                    :bigint(8)        not null, primary key
#  name                  :citext           not null
#  groups_count          :integer          default(0), not null
#  parts_of_speech_count :integer          default(0), not null
#
# Indexes
#
#  index_words_on_name  (name) UNIQUE
#

class Word < ApplicationRecord
  has_many :groupings, dependent: :destroy
  has_many :groups, through: :groupings
  has_many :parts_of_speech, dependent: :destroy
  has_many :search_records_words, dependent: :destroy
  has_many :search_records, through: :search_records_words
end
