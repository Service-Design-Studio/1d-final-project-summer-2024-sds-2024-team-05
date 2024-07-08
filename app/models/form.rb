class Form < ApplicationRecord
    attr_accessor :others_text

    before_save :update_last_edit

    def status_colour
        if !self.status.nil?
            case self.status
            when 'Pending Assessment'
                '#721c24'
            when 'Meeting Date Pending'
                '#ff9800'
            when 'Pending Service Agreement Form'
                '#721c24'
            else
                '#155724'
            end
        end
    end

    def update_last_edit
        unless changed_attributes.except('last_edit', 'last_viewed').empty?
            puts "Changed attributes: #{changed_attributes.keys}"
            self.last_edit = DateTime.now
        else
            puts "No attributes (excluding 'last_edit' and 'last_viewed') have been changed."
        end
    end

    def update_last_viewed
        self.last_viewed = DateTime.now
        save
    end

    def unseen_changes
        self.last_edit > self.last_viewed
    end

    def self.submittable(bool1, bool2, bool3, bool4, bool5, bool6)
        bool1 && bool2 && bool3 && bool4 && bool5 && bool6
    end
    
    def self.all_required
        return ['edit_1_valid', 'edit_2_valid', 'edit_3_valid', 'mental_uploaded', 'physical_uploaded', 'environment_uploaded']
    end

    def self.page1_required
       return ['first_name', 'last_name', 'gender', 'address', 'relationship', 'languages']
    end

    def self.page2_required
        return ['height', 'weight', 'conditions', 'medication', 'hospital']
    end

    def self.page3_required
        return ['services', 'start_date', 'end_date']
     end

    # before_save do
    #     self.languages.gsub!(/[\[\]\"]/,"") if attribute_present?("languages")
    #     self.conditions.gsub!(/[\[\]\"]/,"") if attribute_present?("conditions")
    #     self.services.gsub!(/[\[\]\"]/,"") if attribute_present?("services")
    # end

    has_one_attached :discharge_summary
    has_one_attached :physical_video
    has_one_attached :mental_video
    has_one_attached :environment_video
    has_one_attached :service_agreement_form
    belongs_to :user
end
