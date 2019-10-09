# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { 'Password' }
  end
end
