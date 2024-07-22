require 'rails_helper'

RSpec.describe Form, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:form) { FactoryBot.create(:form, user: user) }

    it 'is valid with valid attributes' do
      form = FactoryBot.build(:form)
      expect(form).to be_valid
    end

    it 'is invalid with invalid attributes' do
      form = FactoryBot.build(:form, first_name: "")
      expect(form.pg1_valid).to be_falsey
    end

    describe 'update_last_edit' do
    it 'updates last_edit if there are changes' do
      form.first_name = 'NewName'
      expect { form.save }.to change { form.last_edit }
    end

    it 'does not update last_edit if there are no param changes' do
      expect { form.save }.not_to change { form.last_edit }
    end

    it 'updates name if there are changes to name' do
      form = FactoryBot.build(:form)
      form.update(first_name: 'jane')
      expect(form.first_name).to eq('jane')
    end
  end

  describe 'submittable' do
  #   it 'returns true if all pages are valid' do
  #     expect(form.submittable).to be_truthy
  #   end

    it 'returns false if page 1 is not valid' do
      form.first_name = ''
      expect(form.submittable).to be_falsey
    end

    it 'returns false if page 2 is not valid' do
      form.height = nil
      expect(form.submittable).to be_falsey
    end

    it 'returns false if page 3 is not valid' do
      form.start_date = nil
      expect(form.submittable).to be_falsey
    end
  end
end