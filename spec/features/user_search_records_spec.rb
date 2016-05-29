require 'rails_helper'

RSpec.feature "User Search Recods" do
  use_moby_cats
  let(:user) { FactoryGirl.create :user }


  scenario 'Users see searched history' do
    sign_in user
    visit root_path
    search_for 'bobcat'

    click_link 'Search Records'
    expect(page).to have_link 'bobcat'
  end
end
