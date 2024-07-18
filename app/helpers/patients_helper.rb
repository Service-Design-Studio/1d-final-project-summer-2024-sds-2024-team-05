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

        def pending_assessment?(form)
          form.application_status == 'Pending Assessment'
        end
      
        def meeting_date_pending_and_no_start_time?(form, meeting)
          form.application_status == 'Meeting Date Pending' && (meeting.nil? || meeting.start_time.blank?)
        end
      
        def meeting_tab_class(form, meeting)
          if meeting_date_pending_and_no_start_time?(form, meeting)
            'text-orange'
          else
            ''
          end
        end
      
        def assessment_tab_class(form)
          pending_assessment?(form) ? 'text-danger' : ''
        end
      
        def meeting_tab_disabled?(form)
          pending_assessment?(form) ? 'disabled' : ''
        end
      
    
end
