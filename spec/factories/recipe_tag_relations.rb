FactoryBot.define do
  factory :recipe_tag_relation do
    association :recipe
    association :recipe_tag
  end
end
