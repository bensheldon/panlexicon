
class Search
  attr_reader :words, :max_words, :buckets

  MAX_WORDS = 80
  BUCKETS = 8

  def initialize(words)
    @words = Array(words)
    @max_words = MAX_WORDS
    @buckets = BUCKETS
  end

  # Step 1
  def intersect_gids
    words.map{|t| t.groups.pluck(:id) }.inject(:&)
  end

  # Step 2
  def words_with_raw_group_counts
    group_ids = intersect_gids

    ActiveRecord::Base.connection.execute("
      SELECT word.id,
             word.name,
             grouping.group_count AS search_group_count,
             ntile(#{buckets}) OVER (ORDER BY grouping.group_count) AS search_bucket
        FROM (
          SELECT word_id, COUNT(*) as group_count FROM groupings
          WHERE group_id IN (#{group_ids.join %q|,| })
          GROUP BY word_id ORDER BY group_count DESC LIMIT #{max_words}
        ) grouping
        LEFT JOIN words word ON word.id = grouping.word_id;
    ").map do |row|
      word = Word.instantiate row
      word.search_group_count = row['search_group_count']
      word.search_bucket = row['search_bucket']
      word
    end
  end

end
