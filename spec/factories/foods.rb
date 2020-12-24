FactoryBot.define do
  factory :food do
    name         { Faker::Games::Pokemon.name }
    time         { Faker::Number.between(from: 1, to: 10) }
    unit_id      { Faker::Number.between(from: 1, to: 3) }
    food_tag_id  { Faker::Number.between(from: 1, to: 10) }
  end
end
