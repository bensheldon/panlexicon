require 'rails_helper'

RSpec.describe SearchController do
  describe 'routing' do
    it 'ROOT routes to #panlexion' do
      expect(get: '/').to route_to('search#panlexicon')
    end

    # This does not work because Rails Advanced Routing Constraints
    # don't show up in routing tests. This is tested in Integration Specs
    #
    # it 'ROOT with query routes to #search' do
    #   expect(get('/?query=lion,tiger')).to route_to('search#search', q: 'lion,tiger')
    # end

    it 'GET /search routes to #search' do
      expect(get('/search')).to route_to('search#search')
    end

    it 'GET /search/:query routes to #search' do
      expect(get('/search/lion,tiger')).to route_to('search#search', query: 'lion,tiger')
    end

    it 'GET /search/?query= routes to #search' do
      expect(get('/search/?query=lion,tiger')).to route_to('search#search', query: 'lion,tiger')
    end

    it 'GET /search/?q= routes to #search' do
      expect(get('/search/?q=lion,tiger')).to route_to('search#search', q: 'lion,tiger')
    end

    it 'POST /search routes to #redirect_post' do
      expect(post('/search')).to route_to('search#redirect_post')
    end
  end
end
