# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  key_term_id :integer          not null
#

class Group < ActiveRecord::Base
  belongs_to :key_term, class_name: "Term"

  has_and_belongs_to_many :terms, join_table: 'groupings'

  validates_presence_of :key_term_id
  validates_uniqueness_of :key_term_id

end
