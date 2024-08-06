Given('that a NOK has successfully submitted a form') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
end

And('I am a staff and I am in the staff dashboard looking for a specific patient form') do
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  visit 'patients/dashboard'
end

When('I type in the patient name or the NOK name') do
  fill_in 'Enter Client\'s/NOK\'s Name', with: 'Sally Tan'
end

And('I click the search button') do
  click_button 'Search'
end

Then('I should only see the form of the patient or the NOK with that specific name being listed out') do
  page.assert_text('Sally Tan')
end

Given('that a NOK has submitted a form') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
end

And('I am a staff and I am done looking for a specific patients form') do
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  visit 'patients/dashboard'
  fill_in 'Enter Client\'s/NOK\'s Name', with: 'Sally Tan'
  click_button 'Search'
end

When('I click the clear button') do
  click_button 'Clear'
end

Then('I should be brought back to the main dashboard with all the forms') do
  page.assert_text('Submitted Forms')
end

Given('that multiple NOKs has submitted forms') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  visit '/forms/new'
  fill_in 'first_name', with: 'Angie'
  fill_in 'last_name', with: 'Wong'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

And('I am a staff and I want to sort all the forms i have by alphabatical order of the patient name') do
  visit 'patients/dashboard'
end

When('I click the sort checkbox next to patient name') do
  check("sort_name")
end

Then('I should see that all the patient names have been sorted in alphabatical order') do
  patient_names = all('.patient_name').map(&:text)
  expect(patient_names).to eq(patient_names.sort)
end

Given('that different NOKs has submitted forms') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  visit '/forms/new'
  fill_in 'first_name', with: 'Angie'
  fill_in 'last_name', with: 'Wong'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

And('I am a staff and I want to sort all the forms i have by alphabatical order of the address of the patient') do
  visit 'patients/dashboard'
end

When('I click the sort checkbox next to address') do
  check("sort_address_submitted")
end

Then('I should see that all the address have been sorted in alphabatical order') do
  address = all('.address').map(&:text)
  expect(address).to eq(address.sort)
end

Given('that NOKs has submitted forms') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  visit '/forms/new'
  fill_in 'first_name', with: 'Angie'
  fill_in 'last_name', with: 'Wong'
  choose('Male')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
  click_button 'Save'
  click_button 'Next'
  check('Showering')
  fill_in 'services_other', with: 'NIL'
  fill_in 'start_date', with: '14072024'
  fill_in 'end_date', with: '18122024'
  click_button 'Save'
  click_button 'Next'
  attach_file('physical_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  attach_file('mental_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

And('I am a staff and I want to sort all the forms i have by male or female patients') do
  visit 'patients/dashboard'
end

When('I click the M checkbox next to gender') do
  check("sort_submitted_male")
end

Then('I should see all the male patients appear above the female patients') do
  # Fetch gender from the appropriate column
  patient_genders = all('table tr > td:nth-child(2)').map(&:text)  # Adjust the nth-child if the gender column is not the second one
  # Find the index positions of male and female entries
  male_positions = patient_genders.each_index.select { |i| patient_genders[i].casecmp('male') == 1 }
  female_positions = patient_genders.each_index.select { |i| patient_genders[i].casecmp('female') == 1 }
  # Check if the last male position is less than the first female position
  unless male_positions.empty? || female_positions.empty?
    expect(male_positions.last).to be < female_positions.first
  end
end


Given('that many NOKs has submitted forms') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/edit_1'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  visit '/forms/new'
  fill_in 'first_name', with: 'Angie'
  fill_in 'last_name', with: 'Wong'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
  click_button 'Save'
  click_button 'Next'
  check('Showering')
  fill_in 'services_other', with: 'NIL'
  fill_in 'start_date', with: '14072024'
  fill_in 'end_date', with: '18122024'
  click_button 'Save'
  click_button 'Next'
  attach_file('physical_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  attach_file('mental_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

And('I am a staff and I want to sort all the forms i have by earliest start date or end date') do
  visit 'patients/dashboard'
end

When('I click the sort checkbox next to start date or end date') do
  check("sort_submitted_date")
end

Then('I should see that all the address have been sorted by earliest start date or end date') do
  displayed_dates = all(".start_date_column").map(&:text)
  sorted_dates = displayed_dates.map { |date| Date.parse(date) }.sort
  expect(displayed_dates).to eq(sorted_dates.map(&:to_s))
end

Given('that I am a staff and I cannot differentiate between the new forms that have just been submitted recently and the older forms that have been submitted some time ago') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

When('a new form has just been submitted by the NOK') do
  visit 'patients/dashboard'
end

Then('I should see the words “New Changes Made!” under the patients name') do
  page.assert_text('New Changes Made!')
end


Given('that NOK has filled up their forms wrongly after submitting or does not know how to fill up') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

And('I am a staff and I want to help a NOK edit their form on their behalf as they filled in the forms wrongly or does not know how to fill up') do
  visit 'patients/dashboard'
end

When('I click on the edit button of the patient’s form on the staff dashboard') do
  find("#edit_1").click
end

And('I make the necessary edits i need to the form') do
  expect(find_field('first_name').value).to eq 'Sally'
  fill_in 'first_name', with: 'Max'
end

And('I click save and exit out of the form') do
  click_button 'Save'
  visit 'patients/dashboard'
end

Then('my changes should be saved') do
  page.assert_text('Max')
end

Given('that I am a staff and I want to find information but I do not know which page the information is on') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Sally'
  fill_in 'last_name', with: 'Tan'
  choose('Female')
  fill_in 'date_of_birth', with: '12101960'
  check('English')
  fill_in 'languages_other', with: 'NIL'
  fill_in 'address', with: 'Dover Road'
  choose('Direct Family member')
  fill_in 'hobbies', with: 'sleeping'
  click_button 'Save'
  click_button 'Next'
  fill_in 'height', with: '150'
  fill_in 'Weight', with: '50'
  check('Dementia')
  fill_in 'Other Conditions', with: 'NIL'
  fill_in 'Medication', with: 'NIL'
  choose('No')
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\sds.mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
end

When('I click the summary button on the dashboard') do
  visit 'patients/dashboard'
  click_link("view_summary_1")
end

Then('I should see a summary of all the information the patient has filled up in their forms and can find the information at once') do
  page.assert_text('Form Details')
end
