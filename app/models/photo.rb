# app/models/photo.rb
class Photo < ApplicationRecord
    has_one_attached :image
    validates :image, presence: true
    validates :tag, presence: true
  end
  