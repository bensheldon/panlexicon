module System
  module SessionHelpers
    def sign_in(user, password = 'password')
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

    def sign_out
      visit destroy_user_session_path
      # # expect(page).to have_link 'Sign out'
      # click_link 'Log out'
    end
  end
end

RSpec.configure do |config|
  config.include System::SessionHelpers, type: :system
end
