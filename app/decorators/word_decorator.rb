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

  def fragments
    return [] if panlexicon?
    search.fragments
  end

  def in_search?
    return false if panlexicon?
    fragments.map { |f| f.word.id }.include? object.id
  end

  def add_to_search_param
    (fragments.map(&:word) + [object]).map(&:name).join(', ')
  end

  def remove_from_search_param
    fragments.map(&:word).reject { |w| w.id == object.id }.map(&:name).join(', ')
  end
end
