# frozen_string_literal: true

# == Schema Information
#
# Table name: word_of_the_days
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  word_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_word_of_the_days_on_date     (date) UNIQUE
#  index_word_of_the_days_on_word_id  (word_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (word_id => words.id)
#

class WordOfTheDay < ApplicationRecord
  GMT_BREAK_HOUR = 4 # Midnight EST is 4 GMT

  belongs_to :word

  validates :date, presence: true, uniqueness: true
  validates :word, presence: true, uniqueness: true
  validates :date, presence: true

  def records_start_at
    records_end_at - 1.day
  end

  def records_end_at
    date.dup
        .in_time_zone('GMT')
        .change hour: GMT_BREAK_HOUR,
                min: 0,
                sec: 0
  end
end
