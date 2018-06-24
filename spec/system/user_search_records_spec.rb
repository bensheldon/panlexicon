require 'rails_helper'

RSpec.describe "User Search Records", type: :system do
  use_moby_cats
  let(:user) { FactoryBot.create :user }

  it 'Users see searched history' do
    sign_in user
    visit root_path
    search_for 'bobcat'

    click_link 'Search Records', match: :first
    expect(page).to have_link 'bobcat'
  end
end
