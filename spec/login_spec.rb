require 'rails_helper'
RSpec.describe 'Login', type: :system do
  before :all do
    unless User.find_by(email: 'test@gmail.com')
      new_user = User.new(name: 'test', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
      new_user.save!
    end
  end
  describe 'Login page' do
    it 'shows the right content' do
      visit user_session_path
      expect(page).to have_content('Remember me')
      expect(page).to have_content('Log in')
      click_button 'Log in'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it ' Give error when submit button with incorrect data' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'example@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
    it 'submit button when filling in with correct data' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'example@gmail.com', with: 'test@gmail.com'
        fill_in 'Your Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  
end
end