require 'spec_helper'

feature 'Search History', js: true do
  use_moby_cats

  scenario 'Displays searched words' do
    visit root_path
    search_for 'bobcat'

    visit history_path
    expect(page).to have_link 'bobcat'
  end
end
