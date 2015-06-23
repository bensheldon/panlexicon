class SearchDecorator < Draper::Decorator
  alias_method :search, :object
  delegate_all

  def results
    WordDecorator.decorate_collection search.results, context: context.merge(search: self)
  end
end
