# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create :user }

  it 'Users can sign in and out' do
    sign_in user
    expect(page).to have_text "Signed in successfully."
    # expect(page).to have_link 'Sign out'
    sign_out
    expect(page).to have_text "Signed out successfully."
    # expect(page).not_to have_link 'Sign out'
  end

  it 'User cannot log in with incorrect password' do
    sign_in user, 'wrong_password'
    expect(page).to have_text 'Invalid Email or password'
    expect(page).not_to have_link 'Sign out'
  end
end
