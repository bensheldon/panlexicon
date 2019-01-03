# == Schema Information
#
# Table name: groups
#
#  id          :bigint(8)        not null, primary key
#  key_word_id :integer          not null
#  words_count :integer          default(0), not null
#
# Indexes
#
#  index_groups_on_key_word_id  (key_word_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (key_word_id => words.id)
#

class Group < ApplicationRecord
  belongs_to :key_word, class_name: 'Word'

  has_many :groupings
  has_many :words, through: :groupings

  validates :key_word_id, presence: true, uniqueness: true
end
