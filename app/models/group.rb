# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  key_word_id :integer          not null
#

class Group < ActiveRecord::Base
  belongs_to :key_word, class_name: 'Word'

  has_many :groupings
  has_many :words, through: :groupings

  validates :key_word_id, presence: true
  validates :key_word_id, uniqueness: true
end
