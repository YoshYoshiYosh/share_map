class AuthorizedMap < ApplicationRecord
  belongs_to :user
  belongs_to :map

  # scopeをuserのemailにして、ユニークにする
  # validates :map, uniqueness: { scope: [:user_id] }
end
