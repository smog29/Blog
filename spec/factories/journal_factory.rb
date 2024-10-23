FactoryBot.define do
  factory :journal do
    title { "My First Blog" }
    association :user

    trait :with_posts do
      after(:create) do |blog|
        create_list(:post, 3, blog: blog)
      end
    end
  end
end
