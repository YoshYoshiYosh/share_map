# frozen_string_literal: true

class Map < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :pins

  has_many :authorized_maps, foreign_key: 'map_id'
  has_many :authorized_users, through: :authorized_maps, source: :user

  validates :title, presence: true

  def authorizing_user(params, user)
    authorized_user = User.find_by!(params)
    if authorized_user == user || AuthorizedMap.find_by(map: self, user: authorized_user)
      errors[:base] << '招待済みのユーザー、もしくは自身を招待することはできません'
      false
    else
      authorized_users.push(authorized_user)
    end
  end
end
