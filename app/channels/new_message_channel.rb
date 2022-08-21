# frozen_string_literal: true

class NewMessageChannel < ApplicationCable::Channel
  def subscribed
    current_user.received_messages.sent.each(&:broadcast!)
    stream_from Broadcaster::URL.new_message(current_user.id)
  end
end
