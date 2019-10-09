# frozen_string_literal: true

FactoryBot.define do
  factory :pin do
    sequence(:title) { |n| "test#{n}-title" }
    sequence(:description) { |n| "test#{n}-description" }
    lonlat { 'POINT(10 10)' }
    association :map
    association :author

    trait :same_author do
      author { map.author }
    end
  end
end
