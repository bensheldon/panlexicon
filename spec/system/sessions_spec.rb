require 'spec_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create :user }

  it 'Users can sign in and out' do
    sign_in user
    expect(page).to have_text "You've been signed in."
    expect(page).to have_link 'Sign out'
    sign_out
    expect(page).to have_text "You've been signed out."
    expect(page).not_to have_link 'Sign out'
  end

  it 'User cannot log in with incorrect password' do
    sign_in user, 'wrong_password'
    expect(page).to have_text 'Invalid email/password combination'
    expect(page).not_to have_link 'Sign out'
  end
end
