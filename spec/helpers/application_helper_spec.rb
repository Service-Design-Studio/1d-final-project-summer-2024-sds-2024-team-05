require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#readable_date' do
    it 'formats a date as "day month year"' do
      date = Date.new(2024, 7, 25) # Example date: July 25, 2024
      expect(helper.readable_date(date)).to eq('25 July 2024')
    end

    it 'handles dates correctly 1' do
      date = Date.new(2024, 1, 1) # Example date: January 1, 2024
      expect(helper.readable_date(date)).to eq('1 January 2024')
    end

    it 'handles dates correctly 2' do
      date = Date.new(2024, 12, 31) # Example date: December 31, 2024
      expect(helper.readable_date(date)).to eq('31 December 2024')
    end

    it 'handles single-digit days' do
      date = Date.new(2024, 7, 3) # Example date: July 3, 2024
      expect(helper.readable_date(date)).to eq('3 July 2024')
    end
  end
end