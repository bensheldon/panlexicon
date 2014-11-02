class SearchController < ApplicationController
  def search
    return panlexicon unless search_query
    return redirect_to(action: 'search', query: search_query) if request.post?

    @search = Search.new(search_query)
    render 'search'
  end

  def panlexicon
    @search = Search.new('thesaurus')
    render 'panlexicon'
  end

  private

  def search_query
    params.permit(:query, :q)

    # First try :query, then try :q
    query = params.fetch(:query, nil)
    query = params.fetch(:q, nil) if query.nil?
    query = nil if query == ''

    query
  end
end
