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

    # def any_pending_assessments?(form)
    #     form.physical_assessment.blank? || form.mental_assessment.blank? || form.environment_assessment.blank?
    # end

    # def meeting_date_pending_and_no_start_time?(meeting)
    #     meeting.start_time.nil? || meeting.start_time.blank?
    # end


      
  
end
