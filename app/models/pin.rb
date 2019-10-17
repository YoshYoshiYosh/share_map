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
      x: self.lonlat.x,
      y: self.lonlat.y,
    }
  end
  
  def custom_image
    url_for(self.image) if self.image.attached?
  end
  
end
