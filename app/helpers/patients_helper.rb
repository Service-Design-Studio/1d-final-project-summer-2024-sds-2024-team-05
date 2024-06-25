module PatientsHelper
    def checked_conditions(area)
        @form.conditions.nil? ? false : @form.conditions.match(area)
    end

    def checked_services(area)
        @form.services.nil? ? false : @form.services.match(area)
    end
end
