class SearchController < ApplicationController
  def show
    return panlexicon unless search_query
    return redirect_to(action: 'show', query: search_query) if request.post?

    @search_query = search_query

    if @search_query
      @search = Search.new(@search_query)
    else
      panlexicon
    end
  end

  def panlexicon
    @search = Search.new('thesaurus')

    render 'show'
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
