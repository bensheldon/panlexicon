
class Search
  attr_reader :terms

  MAX_TERMS = 80

  def initialize(terms)
    @terms = Array(terms)
    @max_terms = MAX_TERMS
  end

  # Step 1
  def intersect_groups
    # Get the list of groups which are shared (exclusive) by the terms
  end

  # Step 2
  def count_termsl
    # From PHP
    #   $sql =
    #    "SELECT Term.id, Term.term, GroupRelation.count
    #     FROM (
    #      SELECT term_id, COUNT(*) as count FROM `group_relations`
    #      WHERE group_id IN (" . implode(',', $groups_intersect) . ")
    #      GROUP BY term_id ORDER BY count DESC LIMIT " . $max_related_terms . "
    #     ) GroupRelation
    #     LEFT JOIN `terms` Term ON Term.id = GroupRelation.term_id;";
    # $results = $this->Term->query($sql);

    ActiveRecord::Base.connection.execute("
      SELECT term.id, term.name, grouping.count
        FROM (
          SELECT term_id, COUNT(*) as count FROM groupings
          WHERE group_id IN (#{term_ids.join %q|'| })
          GROUP BY term_id ORDER BY count DESC LIMIT #{max_terms}
        ) grouping
        LEFT JOIN terms term ON term.id = grouping.term_id;
    ")

  end

end
