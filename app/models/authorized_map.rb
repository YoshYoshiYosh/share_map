# frozen_string_literal: true

class AuthorizedMap < ApplicationRecord
  belongs_to :user
  belongs_to :map

  validates :map, uniqueness: { scope: :user_id }
  validate :user_valid?

  attr_accessor :current_user

  private

  def user_valid?
    if user == current_user
      errors[:base] << '自分を招待することはできません'
    elsif map.authorized_users.include?(user)
      errors[:base] << 'すでに招待されているユーザーです'
    elsif User.all.exclude?(user)
      errors[:base] << '存在しないユーザーは招待できません'
    end
  end
end
