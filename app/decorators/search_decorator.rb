class SearchDecorator < Draper::Decorator
  alias_method :search, :object

  delegate_all

  def results
    WordDecorator.decorate_collection search.results, context: context.merge(search: self)
  end

  def additive_groups
    GroupDecorator.decorate_collection search.additive_groups, context: context.merge(search: self)
  end
end
