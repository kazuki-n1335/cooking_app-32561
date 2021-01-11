FactoryBot.define do
  factory :plan do
    date { Faker::Date.between(from: '2020-09-23', to: '2025-09-25') }
    people { Faker::Number.between(from: 1, to: 10) }
    association :user
    association :recipe
  end
end
