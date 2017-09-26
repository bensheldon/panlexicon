require 'rails_helper'

RSpec.describe 'Mailchimp routing', type: :routing do
  it 'routes after-subscribe' do
    expect(get('/after-subscribe')).to route_to 'mailchimp#after_subscribe'
  end

  it 'routes after-confirm' do
    expect(get('/after-confirm')).to route_to 'mailchimp#after_confirm'
  end
end
