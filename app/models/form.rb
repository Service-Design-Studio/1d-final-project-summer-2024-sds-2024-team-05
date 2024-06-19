class Form < ApplicationRecord
    attr_accessor :others_text

    has_one_attached :discharge_summary
    has_one_attached :physical_video
    has_one_attached :mental_video
    has_one_attached :environment_video
end
