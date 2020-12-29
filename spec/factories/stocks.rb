FactoryBot.define do
  factory :stock do
    num      { Faker::Number.number(digits: 2) }
    food_id  { Faker::Number.between(from: 1, to: 10) }
    association :user
    association :food
  end
end
