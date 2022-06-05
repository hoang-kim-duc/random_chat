FactoryBot.define do
  factory :user_setting do
    from_age { Faker::Number.between(from: 15, to: 20) }
    to_age  { Faker::Number.between(from: 21, to: 30) }
    gender { UserSetting.genders.keys.sample }
    lat { Faker::Address.latitude }
    long { Faker::Address.longitude }
    address { Faker::Address.full_address }
    enable_age_filter { Faker::Boolean.boolean }
    enable_location_filter { Faker::Boolean.boolean }
    enable_gender_filter { Faker::Boolean.boolean }
  end
end
