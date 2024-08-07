# spec/helpers/admins_helper_spec.rb
require 'rails_helper'

RSpec.describe AdminsHelper, type: :helper do
  describe '#status_colour' do
    let(:form) { create(:form) }

    it 'returns the correct color for NA status' do
      expect(helper.status_colour(form)).to eq('color: #10b2c7')
    end

    it 'returns the correct color for form with submitted status without assessments' do
      form.update(submitted: true)
      expect(helper.status_colour(form)).to eq('color: #dc3545')
    end

    it 'returns the correct color for meeting date pending' do
      form.update(physical_assessment: 'good', mental_assessment: 'good', environment_assessment: 'good')
      expect(helper.status_colour(form)).to eq('color: #fd7e14')
    end
    
    # it 'returns the correct color for Upload Service Agreement' do
    #   #meeting is past, time to sign agreement
    #   meeting = create(:meeting, start_time: DateTime.now - 2.days)
    #   form.meeting = meeting
    #   expect(helper.status_colour(form)).to eq('color: #c99b0e')
    # end

    it 'returns the correct color for Onboarded' do
      allow(form).to receive_message_chain(:service_agreement_form, :attached?).and_return(true)
      expect(helper.status_colour(form)).to eq('color: #41ba5d')
    end
  end

  describe '#application_status' do
  let(:form) { create(:form) }

    it 'returns the correct status for not submitted form' do
      expect(helper.application_status(form)).to eq('NA')
    end

    it 'returns the correct color for form with submitted status without assessments' do
      form.update(submitted: true)
      expect(helper.application_status(form)).to eq('Pending Assessment')
    end

    it 'returns the correct color for form with assessments updated' do
      form.update(physical_assessment: 'good', mental_assessment: 'good', environment_assessment: 'good', submitted: true)
      expect(helper.application_status(form)).to eq('Meeting Date Pending')
    end
  end

#----------------------------------------------------------------------------------------------------------------#

  describe '#pending_assessment?' do
  let(:form) { create(:form) }
    it 'returns true for a form pending assessment' do
      form.update(submitted: true)
      expect(pending_assessment?(form)).to eq(true)
    end
  end

  describe '#pending_meeting_date' do
  let(:form) { create(:form) }
    it 'returns true for a form pending meeting date' do
      form.update(physical_assessment: 'good', mental_assessment: 'good', environment_assessment: 'good', submitted: true)
      expect(pending_meeting_date?(form)).to eq(true)
    end
  end

  describe '#pending_service_agreement?' do
  let(:form) { create(:form) }
    it 'returns false for a form just submitted, need to go through other steps' do
      form.update(submitted: true)
      expect(pending_service_agreement?(form)).to eq(false)
    end
  end

  describe '#meeting_tab_class' do
  let(:form) { create(:form) }
    it 'returns "text-danger" for a form pending meeting date' do
      form.update(physical_assessment: 'good', mental_assessment: 'good', environment_assessment: 'good', submitted: true)
      expect(meeting_tab_class(form)).to eq("text-danger")
    end
  end

  describe '#agreement_tab_class' do
  let(:form) { create(:form) }
    it 'returns "" for a form not pending assessment' do
      form.update(submitted: true)
      expect(agreement_tab_class(form)).to eq("")
    end
  end

  describe '#meeting_tab_disabled?' do
  let(:form) { create(:form) }
    it 'returns "disabled" for a form not pending meeting date' do
      form.update(submitted: true)
      expect(meeting_tab_disabled?(form)).to eq("disabled")
    end
  end

  describe '#agreement_tab_disabled?' do
  let(:form) { create(:form) }
    it 'returns "disabled" for a form pending meeting date' do
      form.update(physical_assessment: 'good', mental_assessment: 'good', environment_assessment: 'good', submitted: true)
      expect(agreement_tab_disabled?(form)).to eq("disabled")
    end
  end

  #----------------------------------------------------------------------------------------------------------------#

  describe '#phys_circle' do
    it 'returns the correct HTML for "Good" value' do
      result = helper.phys_circle('Good')
      expected_html = '<div class="assessment-circle assessment-good" data-tooltip="Physical Assessment: Good"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for "Fair" value' do
      result = helper.phys_circle('Fair')
      expected_html = '<div class="assessment-circle assessment-fair" data-tooltip="Physical Assessment: Fair"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for "Poor" value' do
      result = helper.phys_circle('Poor')
      expected_html = '<div class="assessment-circle assessment-poor" data-tooltip="Physical Assessment: Poor"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for nil value' do
      result = helper.phys_circle(nil)
      expected_html = '<div class="assessment-circle assessment-nil" data-tooltip="Physical Assessment: Pending"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for unknown value' do
      result = helper.phys_circle('Unknown')
      expected_html = '<div class="assessment-circle assessment-detailed" data-tooltip="Physical Assessment: Detailed"></div>'
      expect(result.strip).to eq(expected_html)
    end
  end

  describe '#ment_circle' do
    it 'returns the correct HTML for "Good" value' do
      result = helper.ment_circle('Good')
      expected_html = '<div class="assessment-circle assessment-good" data-tooltip="Mental Assessment: Good"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for "Fair" value' do
      result = helper.ment_circle('Fair')
      expected_html = '<div class="assessment-circle assessment-fair" data-tooltip="Mental Assessment: Fair"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for "Poor" value' do
      result = helper.ment_circle('Poor')
      expected_html = '<div class="assessment-circle assessment-poor" data-tooltip="Mental Assessment: Poor"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for nil value' do
      result = helper.ment_circle(nil)
      expected_html = '<div class="assessment-circle assessment-nil" data-tooltip="Mental Assessment: Pending"></div>'
      expect(result.strip).to eq(expected_html)
    end

    it 'returns the correct HTML for unknown value' do
      result = helper.ment_circle('Unknown')
      expected_html = '<div class="assessment-circle assessment-detailed" data-tooltip="Mental Assessment: Detailed"></div>'
      expect(result.strip).to eq(expected_html)
    end
  end
end