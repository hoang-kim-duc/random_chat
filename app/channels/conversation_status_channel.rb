# frozen_string_literal: true

class ConversationStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from Broadcaster::URL.conversation_status(current_user.id)
  end
end
