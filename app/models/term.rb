# == Schema Information
#
# Table name: terms
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class Term < ActiveRecord::Base
  has_and_belongs_to_many :groups, join_table: 'groupings'
end
