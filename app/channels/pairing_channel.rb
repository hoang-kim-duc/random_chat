# frozen_string_literal: true

class PairingChannel < ApplicationCable::Channel
  def subscribed
    stream_for User.find(current_user.id)
  end
end
