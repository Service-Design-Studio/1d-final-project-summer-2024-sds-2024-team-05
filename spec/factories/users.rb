FactoryBot.define do
    factory :user do
        email { "test@gmail.com" }
        password  { "password" }
        user_first_name { "test" }
        user_last_name { "test" }
        user_contact_number { "999999999" }
        user_address { "test" }
        user_postal {259012}
        admin { false }
    end
end