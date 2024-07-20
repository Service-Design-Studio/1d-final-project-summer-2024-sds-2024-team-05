module AdminsHelper
  def status_colour(form)
    if !application_status(form).nil?
        case application_status(form)
        when 'Pending Assessment'
            "color: #721c24"
        when 'Meeting Date Pending'
            "color: #ff9800"
        when 'Pending Service Agreement Form'
            "color: #721c24"
        else
            "color: #155724"
        end
    end
  end

  def application_status(form)
    if form.physical_assessment.present? && form.environment_assessment.present?
      'Meeting Date Pending'
    elsif form.submitted
      'Pending Assessment'
    else
      'NA'
    end
  end
end