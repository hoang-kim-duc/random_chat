# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    caption { 'test' }
    user
    # avatar { Rack::Test::UploadedFile.new('path', 'image/png') }
    after(:build) do |post|
      post.image.attach(
        io: File.open(Rails.root.join('spec', 'fixture_files', 'yeah-boy.png')),
        filename: 'yeah-boy.png',
        content_type: 'image/png'
      )
    end
  end
end
