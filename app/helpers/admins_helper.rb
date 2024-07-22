module AdminsHelper
  def status_colour(form)
    if !application_status(form).nil?
      case application_status(form)
      when 'Onboarded'
          "color: #41ba5d"
      when 'Upload Service Agreement'
          "color: #c99b0e"
      when 'Pending Assessment'
          "color: #dc3545"
      when 'Meeting Date Pending'
          "color: #fd7e14"
      else
          "color: #10b2c7"
      end
    end
  end

  def application_status(form)
    if form.service_agreement_form.present?
      'Onboarded'
    elsif !form.meeting.nil? && form.meeting.past_date
      'Upload Service Agreement'
    elsif !form.meeting.nil?
      "Meeting on #{form.meeting.readable_start}"
    elsif form.physical_assessment.present? && form.environment_assessment.present?
      'Meeting Date Pending'
    elsif form.submitted
      'Pending Assessment'
    else
      'NA'
    end
  end

  def pending_assessment?(form)
    application_status(form) == 'Pending Assessment'
  end

  def meeting_date_pending?(form)
    application_status(form) == 'Meeting Date Pending'
  end

  def meeting_tab_class(form)
    meeting_date_pending?(form) ? 'text-danger' : ''
  end

  def assessment_tab_class(form)
    pending_assessment?(form) ? 'text-danger' : ''
  end

  def meeting_tab_disabled?(form)
    pending_assessment?(form) ? 'disabled' : ''
  end
  
end
    # def application_status
    #     if !meeting.nil? && meeting.past_date
    #         "Upload Service Agreement Form"
    #     elsif !meeting.nil?
    #         "Meeting on #{meeting.readable_start}"
    #     elsif physical_assessment.present? && environment_assessment.present?
    #         'Meeting Date Pending'
    #     elsif submitted
    #         'Pending Assessment'
    #     else
    #         'NA'
    #     end
    # end