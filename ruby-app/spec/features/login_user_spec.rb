require 'rails_helper'

RSpec.describe 'User Log In', type: :feature, js: true do
  let(:user) { create(:user, email: 'testuser@example.com', password: 'password1234') }
  let(:admin) { User.find_by(email: "nursejoon@ninkatec.com") }

  before do
    # Visit the page with the login form
    visit new_user_session_path
  end

  scenario 'allows a user to log in with valid credentials' do
    # Ensure the login tab is visible and active
    expect(page).to have_selector('#login-tab.active')

    # Fill in the login form with valid credentials
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password1234'
    
    # Click the login button
    click_button 'Log in'

    # Verify successful login by checking for a success message or redirection
    expect(page).to have_current_path(user_root_path)
  end

  scenario 'allows an admin to log in with valid credentials' do
    # Ensure the login tab is visible and active
    expect(page).to have_selector('#login-tab.active')

    # Fill in the login form with valid credentials
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'password'
    
    # Click the login button
    click_button 'Log in'

    # Verify successful login by checking for a success message or redirection
    expect(page).to have_current_path(admin_root_path)
  end

  scenario 'does not log in with invalid credentials' do
    # Fill in the login form with invalid credentials
    fill_in 'Email', with: 'wronguser@example.com'
    fill_in 'Password', with: 'wrongpassword'
    
    # Click the login button
    click_button 'Log in'

    expect(page).to have_current_path(new_user_session_path)
  end
end