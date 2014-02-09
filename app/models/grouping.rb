# == Schema Information
#
# Table name: groupings
#
#  group_id :integer          not null
#  word_id  :integer          not null
#

class Grouping < ActiveRecord::Base
  belongs_to :group
  belongs_to :word
end
