class UserConversation < ApplicationRecord
  enum status: [:openning, :self_closed, :closed]

  belongs_to :user
  belongs_to :conversation
end
