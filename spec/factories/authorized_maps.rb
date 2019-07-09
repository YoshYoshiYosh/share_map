FactoryBot.define do
  factory :authorized_map do
    # user { User.create(
    #   email: 'invited-user@example.com',
    #   password: 'Invited-User',
    #   password_confirmation: 'Invited-User'
    # ) }
    # map { Map.create(
    #   title: 'test',
    #   description: 'test',
    #   author: User.first
    # ) }
    association :user
    association :map
  end
end
