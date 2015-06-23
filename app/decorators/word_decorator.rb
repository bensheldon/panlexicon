class WordDecorator < Draper::Decorator
  delegate_all

  def search
    context[:search]
  end

  def panlexicon?
    context.fetch(:is_panlexicon, false)
  end

  def weighted?
    defined? weight
  end

  def searched_words
    return [] if panlexicon?
    search.searched_words
  end

  def in_search?
    return false if panlexicon?
    searched_words.map(&:id).include? object.id
  end

  def add_to_search_param
    (searched_words + [object]).map(&:name).join(', ')
  end

  def remove_from_search_param
    searched_words.reject { |w| w.id == object.id }.map(&:name).join(', ')
  end
end
