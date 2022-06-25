# frozen_string_literal: true

class NewMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from Broadcaster::URL.new_message(current_user.id)
  end
end
