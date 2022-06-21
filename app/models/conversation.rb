# frozen_string_literal: true

class Conversation < ApplicationRecord
  enum status: %i[openning closed]
  has_many :messages
  has_many :user_conversations
  has_many :users, through: :user_conversations
  accepts_nested_attributes_for :user_conversations, reject_if: lambda { |attributes|
                                                                  attributes['user_id'].blank?
                                                                }, allow_destroy: true
end
