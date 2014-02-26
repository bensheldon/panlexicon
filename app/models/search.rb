class Search
  include ActiveModel::Model
  attr_reader :string, :words, :max_words, :buckets

  validates :string, presence: true
  validate :words_exist
  validate :words_have_intersecting_groups

  MAX_WORDS = 80
  BUCKETS = 8

  def initialize(string)
    @string = string
  end

  def words
    @words ||= split_string.map do |name|
      Word.find_by name: name
    end.compact
  end

  def results
    @results ||= weight_related_words
  end

  def group_ids
    @group_ids ||= Array(words.map { |t| t.groups.pluck(:id) }.inject(:&))
  end

  def weight_related_words
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
    ").map { |row| WeightedWord.new(row) }
  end

  private
  def split_string
    string.split(',').map(&:strip)
  end

  def words_exist
    missing_words = split_string - words.map(&:name)

    if missing_words.size > 0
      errors.add(:string, "The #{'word'.pluralize(missing_words.size)} #{missing_words.join(', ')} are not in our dictionary.")
    end
  end

  def words_have_intersecting_groups
    if group_ids.size == 0
      errors.add(:string, 'No commonality can be found between words"')
    end
  end
end
