class SearchDecorator < ApplicationDecorator
  alias_method :search, :object

  def results
    WordDecorator.decorate_collection search.results, context.merge(search: self)
  end

  def additive_groups
    GroupDecorator.decorate_collection search.additive_groups, context.merge(search: self)
  end
end
