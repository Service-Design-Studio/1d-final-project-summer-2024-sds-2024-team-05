# features/step_definitions/user_steps.rb

Given('I am on the first page of the form') do
  visit '/forms/new'
end

When('I click the next button') do
  click_button 'Next'
end

Then('I should be brought to the second page of the form') do
  page.assert_text('New Form - Step 2')
end

Given('I have not completed filling up the form') do
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


