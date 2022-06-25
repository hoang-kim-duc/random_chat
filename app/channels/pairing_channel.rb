# frozen_string_literal: true

class PairingChannel < ApplicationCable::Channel
  def subscribed
    stream_from Broadcaster::URL.pairing(current_user.id)
  end
end
