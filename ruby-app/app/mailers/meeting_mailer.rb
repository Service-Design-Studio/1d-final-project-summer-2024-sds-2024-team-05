class MeetingMailer < ApplicationMailer
  default from: 'custom_sender@example.com'

  def schedule_meeting_email(form, start_time)
    @form = form
    nok = @form.user
    puts nok.email
    mail(to: nok.email,
        subject: 'Meeting Scheduled',
        content_type: "text/html",
        body: <<-HTML
        <html>
        <body>
          <p>Dear #{nok.user_first_name},</p>
          <p>Thank you for registering for our services. Our nurse has scheduled a house visit appointment on <strong>#{start_time.strftime("%B %d, %Y %I:%M %p")}</strong> to assess the situation for patient <strong>#{@form.first_name} #{@form.last_name}</strong> and confirm the service agreements.</p>
          <p>If you are unable to make it or if you have any questions, please contact our nurse at <strong>999999999</strong>.</p>
          <p></p>
          <p>Best regards,</p>
          <p>Your Healthcare Team</p>
        </body>
        </html>
      HTML
    )
  end

  def cancel_meeting_email(form)
    @form = form
    nok = @form.user
    mail(to: nok.email,
        subject: 'Meeting Cancelled',
        content_type: "text/html",
        body: <<-HTML
        <html>
        <body>
          <p>Dear #{nok.user_first_name},</p>
          <p>We regret to inform you that the house visit appointment scheduled for <strong>#{@form.meeting.start_time.strftime("%B %d, %Y %I:%M %p")}</strong> to assess the situation for patient <strong>#{@form.first_name} #{@form.last_name}</strong> and confirm the service agreements has been cancelled.</p>
          <p>We apologize for any inconvenience this may cause. If our nurse has not contacted you about this yet, she will be in contact with you shortly.</p>
          <p>Thank you for your understanding.</p>
          <p>Best regards,</p>
          <p>Your Healthcare Team</p>
        </body>
        </html>
      HTML
    )
  end

  def reschedule_meeting_email(form, old_start_time, new_start_time)
    @form = form
    nok = @form.user
    mail(to: nok.email,
        subject: 'Meeting Rescheduled',
        content_type: "text/html",
        body: <<-HTML
        <html>
        <body>
          <p>Dear #{nok.user_first_name},</p>
          <p>We would like to inform you that the house visit appointment originally scheduled for <strong>#{old_start_time.strftime("%B %d, %Y %I:%M %p")}</strong> has been rescheduled.</p>
          <p>The new appointment date is <strong>#{new_start_time.strftime("%B %d, %Y %I:%M %p")}</strong>. Our nurse will be visiting to assess the situation for patient <strong>#{@form.first_name} #{@form.last_name}</strong> and confirm the service agreements.</p>
          <p>If you have any questions or if the new date is not suitable for you, please contact our nurse at <strong>999999999</strong>.</p>
          <p>Thank you for your flexibility and understanding.</p>
          <p>Best regards,</p>
          <p>Your Healthcare Team</p>
        </body>
        </html>
      HTML
    )
  end
end