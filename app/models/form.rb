class Form < ApplicationRecord
    attr_accessor :others_text

    has_one_attached :discharge_summ
end
