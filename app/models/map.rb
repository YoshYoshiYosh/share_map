class Map < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :pins
  
  has_many :authorized_maps, foreign_key: 'map_id'
  has_many :authorized_users, through: :authorized_maps, source: :user

  validates :title, presence: true

  def authorizing_user(user)
    begin
      self.authorized_users.push(user)
      return true
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid => e
      puts "----------------------------------------------------------------------"
      puts "#{e.class}"
      puts "#{e.message}"
      puts "----------------------------------------------------------------------"
      
      return false
    end
  end
end