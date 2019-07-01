class Map < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :pins

  validates :title, presence: true
end