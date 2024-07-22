module PatientsHelper
    def checked_conditions(area)
        @form.conditions.nil? ? false : @form.conditions.match(area)
    end

    def checked_services(area)
        @form.services.nil? ? false : @form.services.match(area)
    end

    def checked_languages(area)
        @form.languages.nil? ? false : @form.languages.match(area)
    end

    def button_classes(form)
        classes = ["btn btn-primary circular-button btn-blue"] * 6
        classes[0] = "btn btn-primary circular-button btn-outline-red" unless form.pg1_valid
        classes[1] = "btn btn-primary circular-button btn-outline-red" unless form.pg2_valid
        classes[2] = "btn btn-primary circular-button btn-outline-red" unless form.pg3_valid
        classes[3] = "btn btn-primary circular-button btn-outline-red" unless form.pg4_valid
        classes[4] = "btn btn-primary circular-button btn-outline-red" unless form.pg5_valid
        classes[5] = "btn btn-primary circular-button btn-outline-red" unless form.submittable
        classes
      end

    # def any_pending_assessments?(form)
    #     form.physical_assessment.blank? || form.mental_assessment.blank? || form.environment_assessment.blank?
    # end

    # def meeting_date_pending_and_no_start_time?(meeting)
    #     meeting.start_time.nil? || meeting.start_time.blank?
    # end

end
