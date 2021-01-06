FactoryBot.define do
  factory :recipe do
    title { Faker::Lorem.word }
    people { Faker::Number.between(from: 1, to: 10) }
    food {Faker::Lorem.sentence}
    making {Faker::Lorem.sentence}
    introduce {Faker::Lorem.sentence}
    release { Faker::Number.between(from: 0, to: 1) }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
