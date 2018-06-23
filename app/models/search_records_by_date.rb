class SearchRecordsByDate
  include ActiveModel::Model

  MAX_WORDS = 500
  MAX_WEIGHT = 6

  attr_reader :date

  validate :valid_date
  validate :search_records_exist

  def initialize(date)
    @date = date
  end

  def results
    @results ||= weight_search_records
  end

  def weight_search_records
    weighted_records_words = """
      SELECT
        words.*,
        grouping.searched_groups_count AS searched_groups_count,
        ntile(:max_weight) OVER (ORDER BY grouping.searched_groups_count) AS weight
      FROM (
        SELECT word_id, COUNT(*) as searched_groups_count
        FROM search_records_words
        WHERE search_record_id IN (
          SELECT id
          FROM search_records
          WHERE
            created_at >= :start_date AND
            created_at <= :end_date
        )
        GROUP BY word_id ORDER BY searched_groups_count DESC LIMIT :max_words
      ) grouping
      LEFT JOIN words ON words.id = grouping.word_id
      ORDER BY words.name ASC
    """

    # Union the two select statements and fetch a collection of words
    Word.find_by_sql [weighted_records_words, {
      start_date: date,
      end_date: date + 1,
      max_words: MAX_WORDS,
      max_weight: MAX_WEIGHT,
    }]
  end
end
