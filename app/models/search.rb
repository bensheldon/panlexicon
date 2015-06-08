class Search
  include ActiveModel::Model
  attr_reader :string, :words

  validates :string, presence: true
  validate :words_exist
  validate :words_have_intersecting_groups

  MAX_WORDS = 80
  MAX_WEIGHT = 8

  def initialize(string)
    @string = string
  end

  def searched_words
    @searched_words ||= Word.where name: split_string
  end

  def results
    @results ||= weight_related_words
  end

  def group_ids
    @group_ids ||= begin
      select_group_ids = searched_words.map do |word|
        g = Grouping.arel_table
        word_in_grouping = g[:word_id].eq(word.id)

        g.project(:group_id).where(word_in_grouping)
      end

      # Intersection should be done in Arel, but currently can't be chained
      # e.g. select_group_ids.inject(&:intersect) doesn't work
      # https://github.com/rails/arel/pull/320
      query = select_group_ids.map(&:to_sql).join ' INTERSECT '
      result = ActiveRecord::Base.connection.execute query
      if result.count > 0
        result.field_values('group_id').map(&:to_i)
      else
        []
      end
    end
  end

  def missing_words
    @mising_words ||= split_string.map(&:downcase) - searched_words.map(&:name).map(&:downcase)
  end

  private

  def split_string
    string.split(',').map(&:strip)
  end

  def weight_related_words
    Word.find_by_sql(["
      SELECT word.*,
             grouping.groups_count AS groups_count,
             ntile(?) OVER (ORDER BY grouping.groups_count) AS weight
        FROM (
          SELECT word_id, COUNT(*) as groups_count FROM groupings
          WHERE group_id IN (?)
          GROUP BY word_id ORDER BY groups_count DESC LIMIT ?
        ) grouping
        LEFT JOIN words word ON word.id = grouping.word_id
        ORDER BY word.name;
    ", MAX_WEIGHT, group_ids, MAX_WORDS])
  end

  def words_exist
    return unless missing_words.size > 0
    errors.add :string, "#{ sadness_synonym.titleize }. "\
                        "The #{ 'word'.pluralize(missing_words.size) } "\
                        "<strong>#{ missing_words.join(', ') }</strong> "\
                        "#{ missing_words.size == 1 ? 'is' : 'are' } not in our dictionary."
  end

  def words_have_intersecting_groups
    return unless group_ids.size == 0
    errors.add :groups, "#{ sadness_synonym.titleize }. "\
                        'No commonality can be found between '\
                        "<strong>#{ string }</strong>."\
  end

  def sadness_synonym
    %w[sadness despair woe anguish ache distress].sample
  end
end
