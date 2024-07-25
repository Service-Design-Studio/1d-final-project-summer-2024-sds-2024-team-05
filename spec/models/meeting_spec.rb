require 'rails_helper'

RSpec.describe Meeting, type: :model do
  let(:meeting) { build(:meeting) }

  describe 'validations' do
    it 'is invalid without a title' do
      meeting = Meeting.new(title: nil, location: 'Conference Room', start_time: DateTime.now + 1.day)
      expect(meeting).not_to be_valid
      expect(meeting.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a location' do
      meeting = Meeting.new(title: 'Team Meeting', location: nil, start_time: DateTime.now + 1.day)
      expect(meeting).not_to be_valid
      expect(meeting.errors[:location]).to include("can't be blank")
    end

    it 'is invalid without a start_time' do
      meeting = Meeting.new(title: 'Team Meeting', location: 'Conference Room', start_time: nil)
      expect(meeting).not_to be_valid
      expect(meeting.errors[:start_time]).to include("can't be blank")
    end
  end

  describe 'associations' do
    let(:user) { create(:user) }
    let(:form) { FactoryBot.create(:form, user: user) }

    it 'belongs to form' do
      meeting = Meeting.new(title: 'Team Meeting', location: 'Conference Room', start_time: DateTime.now + 1.day, form: form)
      expect(meeting.form).to eq(form)
    end
  end

  describe '#readable_day' do
    it 'returns the day of the week' do
      meeting.start_time = DateTime.new(2024, 7, 25, 10, 0, 0)
      expect(meeting.readable_day).to eq('Thu')
    end
  end

  describe '#readable_datetime' do
    it 'returns the formatted date and time' do
      meeting.start_time = DateTime.new(2024, 7, 25, 10, 0, 0)
      expect(meeting.readable_datetime).to eq('25 July 2024, 10:00am')
    end
  end

  describe '#overflow_date' do
    it 'returns the day and formatted datetime with a line break' do
      meeting.start_time = DateTime.new(2024, 7, 25, 10, 0, 0)
      expect(meeting.overflow_date).to eq("Thu, <br> 25 July 2024, 10:00am")
    end
  end

  describe '#inline_date' do
    it 'returns the day and formatted datetime inline' do
      meeting.start_time = DateTime.new(2024, 7, 25, 10, 0, 0)
      expect(meeting.inline_date).to eq("Thu, 25 July 2024, 10:00am")
    end
  end

  describe '#condensed_time' do
    it 'returns the time in 12-hour format' do
      meeting.start_time = DateTime.new(2024, 7, 25, 14, 0, 0)
      expect(meeting.condensed_time).to eq('2:00 PM')
    end
  end

  describe '#past_date' do
    it 'returns true if the start time is in the past' do
      meeting.start_time = DateTime.now - 1.day
      expect(meeting.past_date).to be true
    end

    it 'returns false if the start time is in the future' do
      meeting.start_time = DateTime.now + 1.day
      expect(meeting.past_date).to be false
    end
  end

  describe '#parsed_start_time' do
    it 'returns the start time in HH:00 format' do
      meeting.start_time = DateTime.new(2024, 7, 25, 14, 30, 0)
      expect(meeting.parsed_start_time).to eq('14:00')
    end
  end

  describe '#hours' do
    it 'returns an array of times from 08:00 to 19:00' do
      expect(meeting.hours).to eq(['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00'])
    end
  end
end