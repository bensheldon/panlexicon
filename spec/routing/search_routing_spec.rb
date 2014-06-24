require 'spec_helper'

describe SearchController do
  describe 'routing' do
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

    it 'POST /search routes to #search' do
      expect(post('/search')).to route_to('search#search')
    end
  end
end
