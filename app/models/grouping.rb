# == Schema Information
#
# Table name: groupings
#
#  group_id :integer          not null
#  term_id  :integer          not null
#

class Grouping < ActiveRecord::Base
  belongs_to :group
  belongs_to :term
end
