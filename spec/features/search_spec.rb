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
    search_for 'bobcat'

    expect(page).to have_link 'bobcat'
    expect(page).to have_link 'cat'
  end

  scenario 'Searching with improper capitalizations' do
    visit root_path
    search_for 'BoBcAt'

    expect(page).to have_link 'bobcat'
    expect(page).to have_link 'cat'
  end

  scenario 'Entering 2 comma-separated words in searchbar' do
    visit root_path
    search_for 'wordhoard, dictionary'

    expect(page).to have_link 'wordhoard'
    expect(page).to_not have_link 'work of reference'
  end

  scenario 'Unselecting a word returns the user to front page' do
    visit root_path
    search_for 'bobcat'
    click_link 'bobcat'

    expect(page).to have_link 'thesaurus'
  end

  scenario 'Searching a non-indexed word' do
    visit root_path
    search_for 'the orm'

    expect(page).to have_content 'the orm is not in our dictionary'
  end


  scenario 'Searching words without common synonyms' do
    visit root_path
    search_for 'thesaurus, cat'

    expect(page).to have_content 'No commonality can be found'
  end
end
