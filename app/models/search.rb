class Search
  attr_reader :string, :words, :max_words, :buckets

  MAX_WORDS = 80
  BUCKETS = 8

  def initialize(string)
    @string = string
    @words = load_words
  end

  def intersect_group_ids
    words.map{|t| t.groups.pluck(:id) }.inject(:&)
  end

  def weight_related_words
    group_ids = intersect_group_ids

    ActiveRecord::Base.connection.execute("
      SELECT word.id,
             word.name,
             grouping.groups_count AS groups_count,
             ntile(#{BUCKETS}) OVER (ORDER BY grouping.groups_count) AS bucket
        FROM (
          SELECT word_id, COUNT(*) as groups_count FROM groupings
          WHERE group_id IN (#{group_ids.join %q|,| })
          GROUP BY word_id ORDER BY groups_count DESC LIMIT #{MAX_WORDS}
        ) grouping
        LEFT JOIN words word ON word.id = grouping.word_id;
    ").map{ |row| WeightedWord.new(row) }
  end

  private
  def load_words
    split_string.map do |name|
      Word.find_by name: name
    end
  end

  def split_string
    string.split(',').map(&:strip)
  end

end
