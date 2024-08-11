require 'rails_helper'

RSpec.describe 'Schedule meeting', type: :feature, js: true do
  let(:user) { create(:user, email:"testing1234567@gmail.com") }
  let(:admin) { User.find_by(email: "nursejoon@ninkatec.com") }
  before do 
    sign_in admin 
  end

  scenario 'Create Meeting and fail because invalid input' do
    visit admin_root_path
    click_button 'Scheduled Meetings'
    click_button 'Create Meeting'
    fill_in 'Location', with: 'test'
    current_datetime = Time.now.strftime('%m-%d-%Y %I:%M %p')
    fill_in 'Start time', with: current_datetime
    # Submit the form inside the modal
    within '#createMeetingModal' do
    click_button 'Create Meeting'
    end
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'Create Meeting and pass' do
    visit admin_root_path
    click_button 'Scheduled Meetings'
    click_button 'Create Meeting'
    fill_in 'Location', with: 'test'
    fill_in 'Title', with: 'test meeting'
    current_datetime = Time.now.strftime('%d-%m-%Y %I:%M %p')
    fill_in 'Start time', with: current_datetime
    # Submit the form inside the modal
    within '#createMeetingModal' do
    click_button 'Create Meeting'
    end
    expect(page).to have_content("test meeting")
  end

  # scenario 'valid application' do
  #   visit new_form_path

  #   fill_in 'first_name', with: 'Minneapolis'
  #   fill_in 'last_name', with: 'hello'
  #   fill_in 'date_of_birth', with: '01-01-1955'
  #   choose 'male'
  #   check 'English'
  #   fill_in 'address', with: 'SUTD'
  #   fill_in 'postal', with: 100000
  #   choose 'Direct Family member'
  #   click_button 'Next'

  #   fill_in 'Height', with: 155
  #   fill_in 'Weight', with: 65
  #   check 'Dementia'
  #   fill_in 'Medication', with: 'test'
  #   choose 'No'
  #   click_button 'Next'

  #   check 'Showering'
  #   current_date = Date.today.strftime('%m-%d-%Y') # Formats date as MM-DD-YYYY
  #   end_date = Date.tomorrow.strftime('%m-%d-%Y') # Formats date as MM-DD-YYYY
  #   fill_in 'start_date', with: current_date
  #   fill_in 'end_date', with: end_date
  #   click_button 'Next'

  #   puts Rails.root.join('spec/fixtures/files/darrel_physical.mp4').to_s
  #   attach_file('physical_video', 'C:\\Users\\royce\\Downloads\\darrel_physical.mp4')
  #   attach_file('mental_video', 'c:\\Users\\royce\\Downloads\\Farm_animals_for_kids_Vocabulary_fo_kids_online_video_cutter_com.mp4')
  #   sleep(10)
  #   click_button 'Save'
  #   sleep(10)
  #   click_button 'Next'
  #   attach_file('environment_video', 'C:\\Users\\royce\\Downloads\\darrel_physical.mp4')

  #   visit cities_path
  #   expect(page).to have_content('Minneapolis')
  # end
end