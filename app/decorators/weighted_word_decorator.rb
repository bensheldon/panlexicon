class WeightedWordDecorator < Draper::Decorator
  delegate_all

  def in_search?
    object.search.searched_words.map { |w| w.id }.include? object.id
  end

  def add_to_search_param
    (object.search.searched_words + [object]).map { |w| w.name }.join(',')
  end

  def remove_from_search_param
    object.search.searched_words.reject { |w| w.id == object.id }.map { |w| w.name }.join(',')
  end
end
