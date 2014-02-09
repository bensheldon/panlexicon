# == Schema Information
#
# Table name: words
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class Word < ActiveRecord::Base
  has_and_belongs_to_many :groups, join_table: 'groupings'
end
