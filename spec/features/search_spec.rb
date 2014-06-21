require 'spec_helper'

feature 'Searching words', js: true do
  use_moby_thesaurus
  use_moby_cats

  scenario 'Clicks through a word on front page' do
    visit root_path
    click_link 'wordhoard'

    expect(page).to have_link 'wordhoard'
    # 'work of reference' and 'wordhoard' have separate sets
    # so it should not be visible here
    expect(page).to_not have_link 'work of reference'
  end

  scenario 'Entering a word in searchbar' do
    visit root_path
    fill_in 'Search', with: 'bobcat'
    click_button 'Search'

    expect(page).to have_link 'bobcat'
    expect(page).to have_link 'cat'
  end

  scenario 'Entering 2 comma-separated words in searchbar' do
    visit root_path
    fill_in 'Search', with: 'wordhoard, dictionary'
    click_button 'Search'

    expect(page).to have_link 'wordhoard'
    expect(page).to_not have_link 'work of reference'
  end

  scenario 'Unselecting a word returns the user to front page' do
    visit root_path
    fill_in 'Search', with: 'bobcat'
    click_button 'Search'
    click_link 'bobcat'

    expect(page).to have_link 'thesaurus'
  end
end
