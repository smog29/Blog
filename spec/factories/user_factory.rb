FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    name { "Test User" }
    password { "password" }
  end
end
