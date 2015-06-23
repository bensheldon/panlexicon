class SearchController < ApplicationController
  def search
    search = Search.new search_query
    @search = SearchDecorator.new search
    render 'search'
  end

  def redirect_post
    redirect_to action: 'search', query: search_query
  end

  def panlexicon
    search = Search.new 'thesaurus'
    @search = SearchDecorator.new search, context: { is_panlexicon: true }
    render 'panlexicon'
  end

  private

  def search_query
    params.permit(:query, :q)

    # First try :query, then try :q
    query = params.fetch(:query, nil)
    query = params.fetch(:q, nil) if query.nil?
    query = '' if query.nil?

    query
  end
end
