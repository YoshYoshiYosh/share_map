# frozen_string_literal: true

class AuthorizedMap < ApplicationRecord
  belongs_to :user
  belongs_to :map

  validates :map, uniqueness: { scope: :user_id }
  validate :user_valid?

  attr_accessor :current_user

  private

  def user_valid?
    if self.user == current_user
      errors[:base] << '自ユーザは追加できません'
    end
  end
end
