require 'rails_helper'

RSpec.describe 'Host Redirection' do
  it 'redirects if the host is not correct' do
    host! 'beta.panlexicon.com'
    expect(get root_path).to redirect_to root_url(host: 'panlexicon.com')
  end
end
