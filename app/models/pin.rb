# frozen_string_literal: true

class Pin < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :image
  belongs_to :author, class_name: 'User'
  belongs_to :map

  validates :title, presence: true
  validates :lonlat, presence: true

  def custom_lonlat
    {
      x: lonlat.x,
      y: lonlat.y
    }
  end
  
  def custom_image
    url_for(image) if image.attached?
  end
  
end
