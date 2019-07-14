class Pin < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :map

  validates :title, presence: true
  validates :lonlat, presence: true
end
