FactoryBot.define do
  factory :recipe_tag do
    tag { Faker::Lorem.word }
  end
end
