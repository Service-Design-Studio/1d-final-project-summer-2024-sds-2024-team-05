class MeetingMailer < ApplicationMailer
  def meeting_email(user)
    @user = user
    puts @user.email
    mail(to: @user.email,
        subject: 'Meeting Scheduled',
        content_type: "text/html",
        body: "<html><strong>Hello there</Strong></html>")
  end
end