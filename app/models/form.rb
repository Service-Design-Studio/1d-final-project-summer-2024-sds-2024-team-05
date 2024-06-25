class Form < ApplicationRecord
    attr_accessor :others_text

    validates :first_name, :last_name, :address, :presence => true

    before_save do
        self.conditions.gsub!(/[\[\]\"]/,"") if attribute_present?("conditions")
        self.services.gsub!(/[\[\]\"]/,"") if attribute_present?("services")
    end

    has_one_attached :discharge_summary
    has_one_attached :physical_video
    has_one_attached :mental_video
    has_one_attached :environment_video
end
