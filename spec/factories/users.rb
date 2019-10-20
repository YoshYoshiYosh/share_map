# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { 'Password' }
    before(:create) do |user|
      user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'support', 'assets', 'test-image.png')),
        filename: "test-image.png",
        content_type: "image/png"
      )
    end
  end
end
