# features/step_definitions/user_steps.rb

#Scenario: Continue to next page

Given('I have signed up and login to my account') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign up'

end

When('I create a new form') do
  visit '/forms/new'
end

When('I click the next button') do
  click_button 'Next'
end

Then('I should be brought to the second page of the form') do
  page.assert_text('New Form - Step 2')
end

#Scenario: Save currently filled information

Given('I have not completed filling up the form') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign up'
  visit '/forms/new'
  fill_in 'first_name', with: 'John'
end

When('I click the save button') do
  click_button 'Save'
end

When('I reopen the form') do
  visit '/forms/1/edit_1'
end

Then('I should not have to re-enter the previously filled up fields') do
  expect(find_field('first_name').value).to eq 'John'
end

#Scenario: Going to a specific page in the form

Given('that I would like to go to a specific page in the form') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign up'
  visit '/forms/new'
end

When('I click on page number {string}') do |page_number|
  click_button(page_number)
end


Then('I should be brought to page {int} of the form') do |page|
  expect(current_path).to eq("/forms/edit_4")
end

#Scenario: Incomplete Page

Given('that I missed filling up a field on one page') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign up'
  visit '/forms/new'
  fill_in 'first_name', with: 'John'
end


When('I move on to the next page') do
  click_button 'Next'
end

Then('I should see the page header of the page with unfilled information be highlighted in red') do
  expect(page).to have_css('button.btn-outline-red', text: '1')
end


#Scenario: Submitting the form


#Given('that I have submitted the form') do
  # make method to simulate form submission in the test setup
  #submit_form_as_submitted
#end

#When('I am in the main dashboard') do
  #visit '/forms'
#end

#Then('I should see the word {string} in the actions') do |word|
  #expect(page).to have_content(word)
#end

#And('I cannot edit or delete the form further') do
  #expect(page).not_to have_selector('button', text: 'Edit')
  #expect(page).not_to have_selector('button', text: 'Delete')
#end
