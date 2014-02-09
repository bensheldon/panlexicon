
class Search
  attr_reader :words

  MAX_WORDS = 80

  def initialize(words)
    @words = Array(words)
    @max_words = MAX_WORDS
  end

  # Step 1
  def intersect_gids
    words.map{|t| t.groups.pluck(:id) }.inject(:&)


    # Get the list of groups which are shared (exclusive) by the words
  end

  # Step 2
  def count_words
    # From PHP
    #   $sql =
    #    "SELECT Word.id, Word.word, GroupRelation.count
    #     FROM (
    #      SELECT word_id, COUNT(*) as count FROM `group_relations`
    #      WHERE group_id IN (" . implode(',', $groups_intersect) . ")
    #      GROUP BY word_id ORDER BY count DESC LIMIT " . $max_related_words . "
    #     ) GroupRelation
    #     LEFT JOIN `words` Word ON Word.id = GroupRelation.word_id;";
    # $results = $this->Word->query($sql);

    ActiveRecord::Base.connection.execute("
      SELECT word.id, word.name, grouping.count
        FROM (
          SELECT word_id, COUNT(*) as count FROM groupings
          WHERE group_id IN (#{intersect_gids.join %q|'| })
          GROUP BY word_id ORDER BY count DESC LIMIT #{max_words}
        ) grouping
        LEFT JOIN words word ON word.id = grouping.word_id;
    ")

  end

end
