#Feature 1: Client info page

#Happy path

#Scenario: Seeing patient information in client information page
Given('that I would like to view a specific client information') do
  visit '/users/sign_up'
  sleep(10)
  fill_in 'Email', with: 'user9@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  fill_in 'User postal', with: '544277'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Susan'
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
  fill_in 'Other Conditions', with: 'NIL'
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
  click_button 'Save'
  click_button 'Next'
  attach_file('environment_video', 'C:\\Users\\charm\\Downloads\\HCI Task 2 .mp4')
  click_button 'Save'
  click_button 'Next'
  click_button 'Submit'
  click_link 'Sign Out'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When('I click on the individual client row') do
  find('a', text: 'Susan', exact: true).click
end


Then('a page will appear showing the client profile with key information') do
  expect(page).to have_content('Client Info')
end
#Sad path

#Scenario: Writing the wrong information of the client in the client profile page

Given('that I am in the client profile page and I realized there are wrong information of the client on the profile page') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
end

When('I click on the edit button in the client profile page') do
  find('#edit').click
end

And('I make the changes I need') do
  fill_in 'date_of_birth', with: '14101970'
end

When('I click save and back') do
  find('#save').click
  find('#back').click
  find('a', text: 'Susan', exact: true).click
end

Then('the changes should be applied and saved and now updated to the new version') do
  expect(page).to have_content('1970-10-14')
end

#Scenario: Accidentally clicking the edit button without changing anything

Given('that I am in the client profile page') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
end

And('I accidentally click on the edit button when I do not intend to make a change') do
  find('#edit').click
end

When('I click back without clicking save') do
  find('#back').click
  find('a', text: 'Susan', exact: true).click
end

Then('no changes would be applied and the information would be as per before I click the edit button') do
  expect(page).to have_content('Birthday: 1970-10-14')
end

#Feature 2: Patient Assessment page

#Sad path
#Scenario: Forgetting to fill in the patient assessment form

Given('that I am on the client profile page and have forgotten to look through the videos and fill in the patient asessment') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#assessment-tab').click
end

Then('I should see the Patient Assessment tab show up as red color') do
  assessment_tab = find("#assessment-tab")
  expect(assessment_tab[:class]).to include("text-danger")
end

#Happy Path

#Scenario: Deciding on the outcome of the assessment

Given('that I am in the process of assessing the physical assessment of the patient') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#assessment-tab').click
end

When('I click on either good fair or poor') do
  choose('good_phy')
end

And('I clicks the button save') do
  find('#save_phy').click
end

Then('I should see that the Physical Assessment should state either good fair or poor depending on the button I chose earlier') do
  expect(page).to have_content('Physical Assessment: Good')
end

#Scenario: Needing to describe the patient in more words other than just simply good fair or poor

Given('that I am assessing the patient and I need to describe the patient in more words other than just simply good fair or poor') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#assessment-tab').click
end

When('I click the detailed assessment button') do
  choose('others_phy')
end

And('I write the information I want to write') do
  fill_in 'others_text_phy', with: 'good mobility'
end

When('I clicked the save button') do
  find('#save_phy').click
end

Then('I should be able to see that the Physical Assessment states the information I wrote') do
  expect(page).to have_content('Physical Assessment: good mobility')
end

#Sad path
#Scenario: Accidentally making edits without saving

Given('that I am on the patient asessment tab and have made previous edits to the physical assessment') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#assessment-tab').click
  choose('others_phy')
  fill_in 'others_text_phy', with: 'good mobility'
  find('#save_phy').click
end

And('I have accidentally typed something unintentional that I did not mean but did not click the save button') do
  fill_in 'others_text_phy', with: 'oops'
end

Then('my changes should not be saved and my previous edits should still be there') do
  expect(page).to have_content('Physical Assessment: good mobility')
end


#Scenario: Writing the wrong information

Given('that I am on the patient asessment tab and I realized that I have assessed the patients physical,mental or environment wrong and need to change my assessment') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#assessment-tab').click
  choose('others_phy')
  fill_in 'others_text_phy', with: 'good mobility'
  find('#save_phy').click
end

When('I make the necessary changes') do
  fill_in 'others_text_phy', with: 'bad mobility'
end

And('I click save button') do
  find('#save_phy').click
end

Then('I should see my changes being saved') do
  expect(page).to have_content('Physical Assessment: bad mobility')
end

#Feature 4: NOK details

#Happy path

#Scenario: Looking for NOK’s contact information

Given('that I want to know what is the NOKs contact information') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
end

When('I am in the client profile page and I click on the tab NOK Details') do
  find('#nok-tab').click
end

Then('I should be able to see the details of the NOK') do
  expect(page).to have_content('NOK Details')
end

#Feature 3: Meeting Details

#Happy Path

#Scenario : Being able to access the Meeting Details page

Given('that I have finished assessing the physical, mental and environmental of the patient') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#assessment-tab').click
  choose('others_mental')
  fill_in 'others_text_mental', with: 'good mental'
  find('#save_mental').click
  choose('others_env')
  fill_in 'others_text_env', with: 'good environment'
  find('#save_env').click
end

And('when I click on the meeting details page') do
  find('#meeting-tab').click
end

Then('I should see a calendar and blanks for me to fill in the description, location and start time and end time') do
  expect(page).to have_css('div.simple-calendar')
  expect(page).to have_content('Description')
  expect(page).to have_content('Location')
  expect(page).to have_content('Start time')
end


#Feature 3: Meeting Details

#Scenario: Setting a meeting in the meeting details page

Given('that I want to set a meeting in the meeting details page') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
end

When('I fill up the description, location, start time and end time') do
  fill_in 'meeting_description', with: 'NIL'
  fill_in 'meeting_location', with: 'changi'
  field = find_field('meeting_start_time')
  field.send_keys("25/07/2024", :tab, "14:00")
end

And('I click the create meeting button') do
  click_button('Create Meeting')
end

Then('I should see the words meeting was successfully created to let me know that the meeting was successfully created') do
  expect(page).to have_content('Title: Susan Tan')
end

#Scenario: After setting the meeting date

Given('that I have finish setting the meeting date') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
end

Then("I should see the patient name and the timing of the meeting on the calendar") do
  expect(find('.simple-calendar')).to have_content('Susan Tan 2:00 PM')
end

#Scenario: After setting the meeting date

Given('that I have finished setting the meeting date') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
end

Then("I should be able to see the meeting details in a card below the calendar along with two buttons show this meeting and destroy this meeting") do
  expect(page).to have_content('Title: Susan Tan')
  expect(page).to have_content('Description: NIL')
  expect(page).to have_content('Location: changi')
end


Then('I should see that the status on the Action Required states the meeting day, date and time in blue') do
  row = find('table', text: 'Susan')
  action_required = row.all('td')[3]
  expect(action_required[:class]).to include('text-blue')
end

#Feature 3: Meeting Details

#Scenario: Using the calendar

Given('that I want to see the next month in the calendar, when I click the button Next') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
  find('.calendar-heading a', text: 'Next').click
end

Then("I should be brought to the next month in the calendar") do
  expect(page).to have_content('August 2024')
end

#Scenario: Using the calendar

Given('that I want to see the previous month in the calendar, when I click the button Previous') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
  find('.calendar-heading a', text: 'Previous').click
end

Then("I should be brought to the previous month") do
  expect(page).to have_content('June 2024')
end

#Scenario: Details of other patients

Given('that I am on a individual client profile meeting date page and I want to check other clients previously already set meeting details') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
end

When('I click on their meeting details on the calendar') do
  find('a', text: 'Susan Tan 2:00 PM', exact_text: true).click
end


Then("I should be able to see their meeting details even though I am not in the overall calendar page nor am I in that specific client that I was checking on page") do
  expect(page).to have_content('Title: Susan Tan')
  expect(page).to have_content('Description: NIL')
  expect(page).to have_content('Location: changi')
end

#Sad path
# Scenario: Far away from the current date in the calendar

Given('that I have clicked on other months and I am not on the current month in the calendar, when I click the button Today') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
  find('.calendar-heading a', text: 'Previous').click
  find('.calendar-heading a', text: 'Today').click
end

Then("I should be brought back to the current month from any month I was at.") do
  expect(page).to have_content('July 2024')
end

#Scenario: Deleting the meeting date

Given('that I have finished setting the meeting date but I realized I want to cancel the meeting') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
end

When('I click on the button destroy this meeting under the meeting details') do
  click_button('Destroy this meeting')
end

Then('I should not see the meeting in the calendar anymore') do
  expect(page).not_to have_css('.simple-calendar', text: 'Susan Tan 2:00 PM', visible: true)
end

#Feature 5: Upload Service agreement form

#Sad path

Given('that I am in the client profile and I have the signed service agreement form but have not uploaded or forgotten to upload it') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
  find('#meeting-tab').click
  fill_in 'meeting_description', with: 'NIL'
  fill_in 'meeting_location', with: 'changi'
  field = find_field('meeting_start_time')
  field.send_keys("25/07/2024", :tab, "15:00")
  click_button('Create Meeting')
  sleep(10)
end

Then('I should see the Service Agreement tab turn red color') do
  agreement_tab = find("#agreement-tab")
  expect(agreement_tab[:class]).to include("text-danger")
end

#Happy Path

Given('that I have the signed service agreement form after meeting the patient and I am in the client profile page and wish to upload it') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  find('a', text: 'Susan', exact: true).click
end

When("I click on the service agreement tab") do
  find('#agreement-tab').click
end

And("I click choose file on the tab and upload the service agreement form") do
  attach_file('svs_agreement', 'C:\\Users\\charm\\Downloads\\slides.pdf')
end

And("I click save") do
  click_button 'Save'
end

Then('I should see the words service agreement preview and see a pdf preview of the service agreement I have uploaded indicating that the service agreement form has been uploaded successfully') do
  expect(page).to have_selector("iframe[src*='slides.pdf']")
end
