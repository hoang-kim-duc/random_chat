# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email  { Faker::Internet.unique.email }
    gender { User.genders.keys.sample }
    password { 'abcdef' }
    password_confirmation { 'abcdef' }
    # avatar { Rack::Test::UploadedFile.new('path', 'image/png') }
    after(:build) do |user|
      user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixture_files', 'yeah-boy.png')),
        filename: 'yeah-boy.png',
        content_type: 'image/png'
      )
    end
  end
end
