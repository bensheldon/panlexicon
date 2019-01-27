# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Daily History', type: :system do
  use_moby_cats

  before do
    10.downto(1).each do |number_of|
      Timecop.travel number_of.days.ago do
        visit root_path
        search_for 'bobcat'
      end
    end
  end

  it 'Displays searched words' do
    visit histories_path
    expect(page).to have_link('bobcat', count: 10)
  end

  context 'when account history' do
    let(:user) { FactoryBot.create :user }

    it 'Users see searched history' do
      sign_in user
      visit root_path
      search_for 'bobcat'

      click_on 'Settings'
      click_on 'Search History', match: :first
      expect(page).to have_link 'bobcat'
    end
  end
end
