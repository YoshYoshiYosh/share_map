# frozen_string_literal: true

class AuthorizedMap < ApplicationRecord
  belongs_to :user
  belongs_to :map

  validates :map, uniqueness: { scope: :user_id }
end
