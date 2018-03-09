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
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (word_id => words.id)
#

class Grouping < ApplicationRecord
  belongs_to :group, counter_cache: :words_count
  belongs_to :word, counter_cache: :groups_count
end
