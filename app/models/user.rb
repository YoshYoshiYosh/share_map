class User < ApplicationRecord
  has_many :maps, inverse_of: 'author', foreign_key: 'author_id'
  has_many :pins, inverse_of: 'author', foreign_key: 'author_id'

  has_many :authorized_maps, foreign_key: 'user_id'
  has_many :can_edit_maps, through: :authorized_maps, source: :map
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
