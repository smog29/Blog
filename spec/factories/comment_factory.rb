FactoryBot.define do
  factory :comment do
    content { "This is a comment." }
    association :user
    association :post
  end
end
