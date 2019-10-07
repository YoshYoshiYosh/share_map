# frozen_string_literal: true

class Map < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :pins

  has_many :authorized_maps, foreign_key: 'map_id'
  has_many :authorized_users, through: :authorized_maps, source: :user

  validates :title, presence: true

  def authorizing_user(user)
    authorized_users.push(user)
  end
end
