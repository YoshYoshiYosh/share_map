# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :maps, inverse_of: 'author', foreign_key: 'author_id'
  has_many :pins, inverse_of: 'author', foreign_key: 'author_id'
  has_many :authorized_maps, foreign_key: 'user_id'
  has_many :can_edit_maps, through: :authorized_maps, source: :map
  
  validates :force_avatar_attached, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def force_avatar_attached
    errors.add(:avatar, 'は添付必須項目です') unless avatar.attached?
  end
  
end
