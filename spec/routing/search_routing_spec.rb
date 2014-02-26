require 'spec_helper'

describe SearchController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get('/search')).to route_to('search#show')
    end

    it 'routes to #show' do
      expect(get('/search/lion,tiger')).to route_to('search#show', query: 'lion,tiger')
    end

    it 'routes to #show' do
      expect(get('/search/?query=lion,tiger')).to route_to('search#show', query: 'lion,tiger')
    end

    it 'routes to #show' do
      expect(get('/search/?q=lion,tiger')).to route_to('search#show', q: 'lion,tiger')
    end

    it 'routes to #create' do
      expect(post('/search')).to route_to('search#show')
    end
  end
end
