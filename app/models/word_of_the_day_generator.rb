# frozen_string_literal: true

class WordOfTheDayGenerator
  attr_reader :word_of_the_day

  def self.generate!(date: Date.current)
    new(date: date).generate!
  end

  def initialize(date: Date.current)
    @date = date
  end

  def generate!
    @word_of_the_day = WordOfTheDay.new(date: @date)
    word_of_the_day.word = find_word_or_random
    word_of_the_day.save!
    word_of_the_day
  end

  def find_word_or_random
    find_word || find_random_word
  end

  def find_random_word
    Word.offset(rand(Word.count)).first
  end

  def find_word
    most_searched_word = <<~SQL.squish
      SELECT
        words.*,
        counting.search_count AS search_count
      FROM (
        SELECT word_id, COUNT(*) as search_count FROM search_records_words
        WHERE search_record_id IN (
          SELECT id
          FROM search_records
          WHERE
            created_at >= :start_datetime AND
            created_at <= :end_datetime
        )
        AND word_id NOT IN (
          SELECT word_id
          FROM word_of_the_days
        )
        GROUP BY word_id ORDER BY search_count DESC LIMIT 1
      ) counting
      LEFT JOIN words ON words.id = counting.word_id
    SQL

    Word.find_by_sql([most_searched_word, {
                       start_datetime: word_of_the_day.records_start_at,
      end_datetime: word_of_the_day.records_end_at,
                     }]).first
  end
end
