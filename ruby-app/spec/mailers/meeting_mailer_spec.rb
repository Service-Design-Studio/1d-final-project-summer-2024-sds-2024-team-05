require 'rails_helper'

RSpec.describe MeetingMailer, type: :mailer do
  describe '#send_meeting_email' do
    let(:meeting) { create(:meeting) }
    let(:user) { create(:user, email: "testing123456@gmail.com") }
    let(:form) { create(:form, user: user, meeting: meeting) }
    let(:start_time) { DateTime.now + 2.days}
    let(:old_start_time) { DateTime.now }

    context 'when schedule email is sent successfully' do
      it 'delivers the email' do
        mail = MeetingMailer.schedule_meeting_email(form, start_time)
        expect {
          mail.deliver_now
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'renders the subject' do
        mail = MeetingMailer.schedule_meeting_email(form, start_time)
        expect(mail.subject).to eq('Meeting Scheduled')
      end

      it 'renders the receiver email' do
        mail = MeetingMailer.schedule_meeting_email(form, start_time)
        expect(form.user.email).to eq("testing123456@gmail.com")
        expect(mail.to).to eq([form.user.email])
      end
    end

    context 'when reschedule email is sent successfully' do
      it 'delivers the email' do
        mail = MeetingMailer.reschedule_meeting_email(form, old_start_time, start_time)
        expect {mail.deliver_now}.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'renders the subject' do
        mail = MeetingMailer.reschedule_meeting_email(form, old_start_time, start_time)
        expect(mail.subject).to eq('Meeting Rescheduled')
      end

      it 'renders the receiver email' do
        mail = MeetingMailer.reschedule_meeting_email(form, old_start_time, start_time)
        expect(form.user.email).to eq("testing123456@gmail.com")
        expect(mail.to).to eq([form.user.email])
      end
    end

    context 'when cancellation email is sent successfully' do
      it 'delivers the email' do
        mail = MeetingMailer.cancel_meeting_email(form)
        expect {mail.deliver_now}.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'renders the subject' do
        mail = MeetingMailer.cancel_meeting_email(form)
        expect(mail.subject).to eq('Meeting Cancelled')
      end

      it 'renders the receiver email' do
        mail = MeetingMailer.cancel_meeting_email(form)
        expect(form.user.email).to eq("testing123456@gmail.com")
        expect(mail.to).to eq([form.user.email])
      end
    end

    context 'email server error' do
      before do
        allow_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_now).and_raise(StandardError, "Simulated email sending failure")
      end

      it 'raises an error when sending email' do
        expect {
          MeetingMailer.schedule_meeting_email(form, start_time).deliver_now
        }.to raise_error(StandardError, "Simulated email sending failure")
      end

      it 'raises an error when sending email' do
        expect {
          MeetingMailer.reschedule_meeting_email(form, start_time).deliver_now
        }.to raise_error(StandardError, "Simulated email sending failure")
      end

      it 'raises an error when sending email' do
        expect {
          MeetingMailer.cancel_meeting_email(form, start_time).deliver_now
        }.to raise_error(StandardError, "Simulated email sending failure")
      end
    end
  end
end