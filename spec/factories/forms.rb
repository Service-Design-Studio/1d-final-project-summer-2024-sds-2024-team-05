FactoryBot.define do
    factory :form do
    association :user
      first_name { "John" }
      last_name { "Doe" }
      gender { "Male" }
      date_of_birth { Date.new(1990, 1, 1) }
      address { "20 Upper Changi Road" }
      relationship { "Single" }
      hobbies { "Reading, Traveling" }
      height { 160 }
      weight { 75 }
      conditions { "Cancer" }
      conditions_other { "N/A" }
      medication { "None" }
      hospital { false }
      services { "Showering" }
      services_other { "N/A" }
      start_date { Date.today }
      end_date { Date.today + 30 }
      languages { "English, Spanish" }
      languages_other { "N/A" }
      mental_primary_assessment { "Good" }
      physical_primary_assessment { "Good" }
      environment_primary_assessment { "Good" }
      mental_assessment { "No issues" }
      physical_assessment { "Good health" }
      environment_assessment { "Good environment" }
      meet_date { DateTime.now }
      nok_address { "25 Upper Changi Road" }
      nok_contact_no { "123-456-7890" }
      nok_first_name { "Jane" }
      nok_last_name { "Doe" }
      nok_email { "jane.doe@example.com" }
      submitted { false }
      last_edit { DateTime.now }
      last_viewed { DateTime.now }

    # # Active Storage attachments
    # after(:build) do |form|
    #     form.physical_video.attach(io: File.open(Rails.root.join('public', 'videos', 'videoUploadForm1.mp4')), filename: 'physical_video.mp4', content_type: 'video/mp4')
    #     form.mental_video.attach(io: File.open(Rails.root.join('public', 'videos', 'videoUploadForm2.mp4')), filename: 'mental_video.mp4', content_type: 'video/mp4')
    #     form.environment_video.attach(io: File.open(Rails.root.join('public', 'videos', 'environment_test.mp4')), filename: 'environment_video.mp4', content_type: 'video/mp4')
    #   end
    end
  end