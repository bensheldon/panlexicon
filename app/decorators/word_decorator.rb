class WordDecorator < ApplicationDecorator
  alias_method :word, :object

  def search
    context[:search]
  end

  def panlexicon?
    context.fetch(:is_panlexicon, false)
  end

  def weight
    word.respond_to?(:weight) ? word.weight : 0
  end

  def searched_groups_count
    word.respond_to?(:searched_groups_count) ? word.searched_groups_count : 0
  end

  def in_search?
    return false if panlexicon?
    search_fragments.find { |f| f.word.id == object.id }.present?
  end

  def subtracted_from_search?
    search_fragments.find { |f| f.word.id == object.id && f.operation == :subtract }.present?
  end

  def add_to_search_query
    (search_fragments + [SearchFragment.new(word: self, operation: :add)]).map do |fragment|
      if fragment.operation == :add
        fragment.word.name
      else
        "-#{fragment.word.name}"
      end
    end.join(', ')
  end

  def remove_from_search_query
    search_fragments.map(&:word).reject { |w| w.id == object.id }.map(&:name).join(', ')
  end

  def search_explanation
    "Weight: #{weight}; Searched Groups Count: #{searched_groups_count}; Groups Count: #{groups_count} "
  end

  private

  def search_fragments
    return [] if panlexicon? # || search.blank?
    search.fragments
  end
end
