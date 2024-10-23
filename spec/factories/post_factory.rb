FactoryBot.define do
  factory :post do
    title { "My First Post" }
    body { "This is the body of the post." }
    association :journal
  end
end
