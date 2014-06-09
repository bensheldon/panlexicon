class SearchController < ApplicationController
  def show
    return panlexicon unless search_query
    return redirect_to(action: 'show', query: search_query) if request.post?

    @search = Search.new(search_query)

    # if @search.valid?

    # else

    # end

    # respond_to do |format|
    #   if @search.save
    #     format.html { redirect_to @search, notice: 'Search was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @search }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @search.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def panlexicon
    @search = Search.new('thesaurus')

    render 'show'
  end

  private
    def search_query
      params.permit(:query, :q)

      params.fetch :query do
        params.fetch :q do
          ''
        end
      end
    end
end
