FactoryBot.define do
  factory :meeting do
    title { "Team Meeting" }
    location { "Conference Room" }
    start_time { DateTime.now + 1.day }
    association :form
  end
end