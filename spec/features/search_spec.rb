require_relative '../spec_helper'

RSpec.describe 'Searching', js: true do
  it 'can add and remove terms to the search' do
    visit "/"

    fill_in 'q', with: "artifice"
    find('#search').native.send_keys(:return)

    expect(page).to have_link 'artifice', class: 'active'

    click_on 'chicanery'
    expect(page).to have_link 'chicanery', class: 'active'
    expect(page).to have_link 'ruse', class: ''

    click_on 'chicanery'
    expect(page).to have_link 'chicanery', class: ''
  end

  it 'returns a message when no results are found' do
    visit "/"

    fill_in 'q', with: ""
    find('#search').native.send_keys(:return)

    expect(page).to have_content 'No search term provided.'
  end

  it 'returns a message when the search term is not found' do
    visit "/"

    fill_in 'q', with: "zxcvbnm"
    find('#search').native.send_keys(:return)

    expect(page).to have_content 'One or more search terms not found.'
  end

  it 'returns a message when there is no intersection of search terms' do
    visit "/"

    fill_in 'q', with: "airplane, banana"
    find('#search').native.send_keys(:return)

    expect(page).to have_content 'No shared meaning found.'
  end
end
