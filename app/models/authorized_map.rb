class AuthorizedMap < ApplicationRecord
  belongs_to :user
  belongs_to :map

  # scopeをuserのemailにして、ユニークにする
  
end
