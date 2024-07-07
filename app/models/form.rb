class Form < ApplicationRecord
    attr_accessor :others_text

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

    before_save do
        self.languages.gsub!(/[\[\]\"]/,"") if attribute_present?("languages")
        self.conditions.gsub!(/[\[\]\"]/,"") if attribute_present?("conditions")
        self.services.gsub!(/[\[\]\"]/,"") if attribute_present?("services")
    end

    has_one_attached :discharge_summary
    has_one_attached :physical_video
    has_one_attached :mental_video
    has_one_attached :environment_video
    has_one_attached :service_agreement_form
    belongs_to :user
end
