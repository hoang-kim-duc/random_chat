# frozen_string_literal: true

class UserConversation < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :conversation

  aasm column: :status do
    state :opening, initial: true
    state :sharing
    state :closed

    event :share_profile do
      transitions from: [:opening, :sharing], to: :sharing
    end
    event :close do
      transitions from: [:opening, :sharing], to: :closed
    end
  end

  after_save :conversation_share_profile, :close_share_profile

  private

  def conversation_share_profile
    all_uc_shared = true
    conversation.user_conversations.each do |user_conversation|
      all_uc_shared &&= user_conversation.sharing?
    end
    conversation.share_profile! if all_uc_shared
  end

  def close_share_profile
    conversation.user_conversations.each do |user_conversation|
      return conversation.close! if user_conversation.closed?
    end
  end
end
