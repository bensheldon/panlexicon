# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  key_word_id :integer          not null
#

class Group < ActiveRecord::Base
  belongs_to :key_word, class_name: 'Word'

  has_and_belongs_to_many :words, join_table: 'groupings'

  validates_presence_of :key_word_id
  validates_uniqueness_of :key_word_id
end
