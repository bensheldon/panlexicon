# == Schema Information
#
# Table name: words
#
#  id           :integer          not null, primary key
#  name         :citext           not null
#  groups_count :integer          default(0), not null
#
# Indexes
#
#  index_words_on_name  (name) UNIQUE
#

class Word < ApplicationRecord
  has_many :groupings
  has_many :groups, through: :groupings
end
