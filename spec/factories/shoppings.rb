FactoryBot.define do
  factory :shopping do
    name         { Faker::Food.fruits }
    num          { Faker::Number.number(digits: 2) }
    category_id  { Faker::Number.between(from: 1, to: 10) }
    association :user
  end
end
