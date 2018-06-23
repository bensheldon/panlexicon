require 'rails_helper'

RSpec.describe 'Daily History', type: :system, js: true do
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
    visit daily_histories_path
    expect(page).to have_link('bobcat', count: 10)
  end
end
