# features/step_definitions/user_steps.rb

#Scenario: Continue to next page

Given('I have signed up and login to my account') do
  visit '/users/sign_up'
  sleep(10)
  fill_in 'Email', with: 'nok6@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  fill_in 'User postal', with: '544277'
  click_button 'Sign Up'
end

When('I create a new form') do
  visit '/forms/new'
end

When('I click the next button') do
  click_button 'Next'
end

Then('I should be brought to the second page of the form') do
  page.assert_text('Page 2 - Medical Conditions')
end


#Scenario: Going to a specific page in the form

Given('that I would like to go to a specific page in the form') do
  visit '/'
  fill_in 'Email', with: 'nok6@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  visit '/forms/new'
end

When('I am on page 1 but I click on the button of page number 4') do
  find('#patient-assessment-button').click
end


Then('I should be brought to page 4 of the form') do
  page.assert_text('Page 4 - Patient Analysis')
end

#Scenario: Incomplete Page

Given('that I missed filling up a field on one page') do
  visit '/'
  fill_in 'Email', with: 'nok6@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  visit '/forms/new'
  fill_in 'first_name', with: ' Jette'
end


When('I move on to the next page') do
  click_button 'Next'
end

Then('I should see the page header of the page with unfilled information be highlighted in red') do
  expect(page).to have_css('button.btn-outline-red', text: '1')
end


#Scenario: Submitting the form


Given('that I have submitted the form') do
  visit '/users/sign_up'
  sleep(10)
  fill_in 'Email', with: 'nok7@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  fill_in 'User postal', with: '544277'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: ' Jette'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  fill_in 'postal', with: '544277'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'Height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'conditions_other', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('Yes')
  click_button 'Save'
  click_button 'Next'
  check('Showering')
  fill_in 'services_other', with: 'NIL'
  fill_in 'start_date', with: '12102024'
  fill_in 'end_date', with: '15122024'
  click_button 'Save'
  click_button 'Next'
  attach_file('physical_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  attach_file('mental_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  sleep(10)
  click_button 'Save'
  sleep(10)
  click_button 'Next'
  sleep(10)
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\HCI Task 2 .mp4')
  sleep(10)
  click_button 'Save'
  sleep(10)
  click_button 'Next'
  sleep(10)
  click_button 'Submit'
  sleep(10)
end

When('I am in the main user dashboard') do
  visit '/'
end

Then('I should see the word submitted') do
  expect(page).to have_content('Submitted')
end
