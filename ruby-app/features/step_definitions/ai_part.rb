#Feature: AI assessment feature
#Happy Path

#Scenario: Checking the AI generated assessment results
Given('that I would like to see the patients AI generated assessment results') do
  visit '/users/sign_up'
  sleep(10)
  fill_in 'Email', with: 'nok1@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  fill_in 'User postal', with: '544277'
  click_button 'Sign Up'
  visit '/forms/new'
  fill_in 'first_name', with: 'Mandy'
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
  attach_file('physical_video', 'C:\\Users\\royce\\Downloads\\darrel_physical.mp4')
  attach_file('mental_video', 'c:\\Users\\royce\\Downloads\\Farm_animals_for_kids_Vocabulary_fo_kids_online_video_cutter_com.mp4')
  sleep(10)
  click_button 'Save'
  sleep(10)
  click_button 'Next'
  sleep(10)
  attach_file('environment_video', 'C:\\Users\\royce\\Downloads\\environment_video.mp4')
  sleep(10)
  click_button 'Save'
  sleep(10)
  click_button 'Next'
  sleep(10)
  click_button 'Submit'
  sleep(10)
  visit '/users/sign_out'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When('I click on the patient assessment tab') do
  find('a', text: 'Mandy', exact: true).click
  find('#assessment-tab').click
end


Then('I should be able to see the Physical Video AI assessment results') do
  expect(page).to have_content('AI Primary Physical Assessment')
end

#Scenario: Transcribing the mental AI video

Given('that I would like to see a transcription of the mental video assessment the patient has uploaded so I do not need to spend time watching the whole video') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When('I clicked on the patient assessment tab') do
  find('a', text: 'Mandy', exact: true).click
  find('#assessment-tab').click
end


Then('I should be able to see the transcription of the mental video assessment') do
  expect(page).to have_content('Transcript:')
end

#Scenario: Determining the mental state of the patient

Given('that I would like to find out the mental state of the patient without watching the mental assessment video') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When('I clicks on the patient assessment tab') do
  find('a', text: 'Mandy', exact: true).click
  find('#assessment-tab').click
end


Then('I should be able to see a section that says animal count, which can help me to determine the mental status of the patient based on how many animals the patient is able to list out') do
  expect(page).to have_content('Animal Count:')
end

#Sad Path

#Scenario: Determining the mental state of the patient

Given('that the AI asssessment results are preliminary and may be incorrect') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When('I am on the patient assessment tab') do
  find('a', text: 'Mandy', exact: true).click
  find('#assessment-tab').click
end


Then('I should still be able to manually input a assessment results based on my own judgement and choose good fair or poor') do
  expect(page).to have_css('input[type="radio"]')
end

And('I should also be able to write additional comments in the assessment details section') do
  fill_in 'physical_assessment_detail', with: 'good mobility'
end

And('these information should be saved when I click the save button') do
  choose('physical_good')
  choose('mental_good')
  choose('environment_good')
  find('#save_env').click
  expect(find_field('physical_good', visible: false)).to be_checked
  expect(find_field('physical_assessment_detail').value).to eq 'good mobility'
end


#Scenario: Having the videos that the patients uploaded available

Given('that the AI assessment results might be incorrect') do
  visit '/'
  fill_in 'Email', with: 'nursejoon@ninkatec.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When('I am on the patients assessment tab') do
  find('a', text: 'Mandy', exact: true).click
  find('#assessment-tab').click
end


Then('I should still be able to view the original videos the patients have uploaded to verify if the AI assessment results are valid or not') do
  expect(page).to have_css('video.img-thumbnail.video-preview.rounded-video')
end
