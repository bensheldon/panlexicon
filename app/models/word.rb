# == Schema Information
#
# Table name: words
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class Word < ActiveRecord::Base
  has_many :groupings
  has_many :groups, through: :groupings
end
