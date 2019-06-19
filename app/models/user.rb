class User < ApplicationRecord
  # has_many :maps, inverse_of: 'author', foreign_key: 'author', class_name: 'Map'
  has_many :maps, inverse_of: 'author', foreign_key: 'author_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
