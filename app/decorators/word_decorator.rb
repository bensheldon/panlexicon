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
    fragments.find { |f| f.word.id == object.id }.present?
  end

  def subtracted_from_search?
    fragments.find { |f| f.word.id == object.id && f.operation == :subtract }.present?
  end

  def add_to_search_param
    (fragments + [SearchFragment.new(word: self, operation: :add)]).map do |fragment|
      if fragment.operation == :add
        fragment.word.name
      else
        "-#{fragment.word.name}"
      end
    end.join(', ')
  end

  def remove_from_search_param
    fragments.map(&:word).reject { |w| w.id == object.id }.map(&:name).join(', ')
  end
end
