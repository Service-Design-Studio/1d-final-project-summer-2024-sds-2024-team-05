require 'rails_helper'

RSpec.describe 'User Registration', type: :feature, js: true do
  scenario 'User signs up successfully with valid details' do
    visit new_user_session_path # Visit the page where the sign-up form is located

    # Click the "Sign Up" tab
    click_button 'Sign Up'

    # Ensure we're on the 'Sign Up' tab
    expect(page).to have_selector('#signup.show.active')

    # Fill in the sign-up form
    fill_in 'User first name', with: 'John'
    fill_in 'User last name', with: 'Doe'
    fill_in 'Email', with: 'john.doe@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    fill_in 'User contact number', with: '1234567890'
    fill_in 'User address', with: '123 Main St'
    fill_in 'User postal', with: '12345'

    # Submit the form
    within('#signup') do
    click_button 'Sign Up'
    end

    # Verify that the user is redirected and sees a success message
    expect(page).to have_content('Welcome John')
    expect(page).to have_current_path(user_root_path) # Adjust path as necessary
  end

  scenario 'User fails to sign up with invalid details' do
    visit new_user_session_path # Visit the page where the sign-up form is located

    # Click the "Sign Up" tab
    click_button 'Sign Up'

    # Ensure we're on the 'Sign Up' tab
    expect(page).to have_selector('#signup.show.active')

    # Fill in the form with invalid details
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'different'

    # Submit the form
    within('#signup') do
    click_button 'Sign Up'
    end

    # Verify that the page shows error messages
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end