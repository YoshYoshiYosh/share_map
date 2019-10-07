# frozen_string_literal: true

class Pin < ApplicationRecord
  has_one_attached :image
  belongs_to :author, class_name: 'User'
  belongs_to :map

  validates :title, presence: true
  validates :lonlat, presence: true
end
