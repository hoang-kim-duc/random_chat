# frozen_string_literal: true

FactoryBot.define do
  factory :user_setting do
    from_age { Faker::Number.between(from: 15, to: 20) }
    to_age { Faker::Number.between(from: 21, to: 30) }
    gender { UserSetting.genders.keys.sample }
    lat { Faker::Address.latitude }
    long { Faker::Address.longitude }
    radius { Faker::Number.between(from: 2, to: 20) }
    address { Faker::Address.full_address }
    enable_age_filter { true }
    enable_location_filter { true }
    enable_gender_filter { true }
  end
end
