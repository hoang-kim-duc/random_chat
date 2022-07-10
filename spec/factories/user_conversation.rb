# frozen_string_literal: true

FactoryBot.define do
  factory :user_conversation do
    user
    conversation
  end
end
