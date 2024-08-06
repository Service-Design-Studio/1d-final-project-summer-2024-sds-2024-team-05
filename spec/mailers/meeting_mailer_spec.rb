require 'rails_helper'

# RSpec.describe MeetingMailer, type: :mailer do
#   describe '#schedule_meeting_email' do
#     let(:form) { create(:form) }
#     let(:start_time) { Time.now }

#     before do
#       allow_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_now).and_raise(StandardError, "Simulated email sending failure")
#     end

#     it 'raises an error when sending email' do
#       expect {
#         MeetingMailer.schedule_meeting_email(form, start_time).deliver_now
#       }.to raise_error(StandardError, "Simulated email sending failure")
#     end
#   end
# end