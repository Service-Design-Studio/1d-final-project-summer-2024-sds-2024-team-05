class ApplicationMailer < ActionMailer::Base
  default from: "MeetingsNotification@test.com"
  layout "mailer"
end
