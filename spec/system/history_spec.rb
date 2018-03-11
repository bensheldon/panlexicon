require 'rails_helper'

RSpec.describe 'Search History', type: :system, js: true do
  use_moby_cats

  it 'Displays searched words' do
    visit root_path
    search_for 'bobcat'

    visit history_path
    expect(page).to have_link 'bobcat'
  end
end
