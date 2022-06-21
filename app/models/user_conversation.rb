# frozen_string_literal: true

class UserConversation < ApplicationRecord
  enum status: %i[openning self_closed closed]

  belongs_to :user
  belongs_to :conversation
end
