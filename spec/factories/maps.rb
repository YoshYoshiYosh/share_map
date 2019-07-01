FactoryBot.define do
  factory :map do
    title { "test-title" }
    description { "test-description" }
    association :author
  end
end
