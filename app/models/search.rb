# frozen_string_literal: true

class Search
  include ActiveModel::Model
  attr_reader :string, :words, :parser, :additive_group_ids, :subtractive_group_ids

  validates :string, presence: true
  validate :words_exist
  validate :groups_intersect

  MAX_RELATED_WORDS = 80
  MAX_WEIGHT = 6

  SADNESS_SYNONYMS = %w[sadness despair woe anguish ache distress].freeze

  WEIGHTED_SEARCH_SQL = File.read Rails.root.join('app/models/sql/weighted_search.sql')
  WEIGHTED_SEARCH_WITH_POS_SQL = File.read Rails.root.join('app/models/sql/weighted_search_with_pos.sql')

  def self.sadness_synonym
    SADNESS_SYNONYMS.sample
  end

  def initialize(string)
    @string = string
    @parser = SearchParser.new string
  end

  delegate :execute, to: :parser

  delegate :fragments, to: :parser

  def results
    @results ||= weight_related_words
  end

  def group_ids
    @group_ids ||= begin
      @additive_group_ids = group_ids_for_fragments additive_fragments
      @subtractive_group_ids = group_ids_for_fragments subtractive_fragments

      additive_group_ids - subtractive_group_ids
    end
  end

  def additive_groups
    @additive_groups ||= Group.where(id: additive_group_ids).includes(:key_word)
  end

  def subtractive_groups
    @subtractive_groups ||= Group.where id: subtractive_group_ids
  end

  delegate :missing_words, to: :parser

  private

  def fragments_with_word
    fragments.select { |fragment| fragment.word.present? }
  end

  def additive_fragments
    fragments_with_word.select { |fragment| fragment.operation == :add }
  end

  def subtractive_fragments
    fragments_with_word.select { |fragment| fragment.operation == :subtract }
  end

  def weight_related_words
    # Union the two select statements and fetch a collection of words
    searched_word_ids = fragments_with_word.map { |fragment| fragment.word.id }

    query_params = {
      max_related_words: MAX_RELATED_WORDS,
      max_weight: MAX_WEIGHT,
      group_ids: group_ids,
      searched_groups_count: group_ids.size,
      searched_word_ids: searched_word_ids,
      pos_codes: Array(@parser.part_of_speech),
    }

    if query_params[:pos_codes].empty?
      Word.find_by_sql [WEIGHTED_SEARCH_SQL, query_params]
    else
      Word.find_by_sql [WEIGHTED_SEARCH_WITH_POS_SQL, query_params]
    end
  end

  def words_exist
    return if missing_words.empty?

    missing_words.each do |missing_word|
      errors.add :missing_words, missing_word
    end
  end

  def group_ids_for_fragments(fragments)
    select_group_ids = fragments.map do |fragment|
      word = fragment.word
      g = Grouping.arel_table
      word_in_grouping = g[:word_id].eq(word.id)

      g.project(:group_id).where(word_in_grouping)
    end

    # Intersection should be done in Arel, but currently can't be chained
    # e.g. select_group_ids.inject(&:intersect) doesn't work
    # https://github.com/rails/arel/pull/320
    query = select_group_ids.map(&:to_sql).join ' INTERSECT '
    result = ActiveRecord::Base.connection.execute query
    if result.count.positive?
      result.field_values('group_id').map(&:to_i)
    else
      []
    end
  end

  def groups_intersect
    return unless group_ids.empty?

    errors.add :groups_not_intersected, true
  end
end
