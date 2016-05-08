# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers
    def sign_in(user, password = 'password')
      visit sign_in_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

    def sign_out
      expect(page).to have_link 'Sign out'
      click_link 'Sign out'
    end
  end
end
