# == Schema Information
#
# Table name: groupings
#
#  group_id :integer          not null
#  word_id  :integer          not null
#
# Indexes
#
#  index_groupings_on_group_id_and_word_id  (group_id,word_id) UNIQUE
#  index_groupings_on_word_id               (word_id)
#
# Foreign Keys
#
#  fk_rails_21fa437bf8  (group_id => groups.id)
#  fk_rails_f4b13e40fd  (word_id => words.id)
#

class Grouping < ActiveRecord::Base
  belongs_to :group
  belongs_to :word
end
