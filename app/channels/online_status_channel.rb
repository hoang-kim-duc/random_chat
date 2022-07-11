# frozen_string_literal: true

class OnlineStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from Broadcaster::URL.online_status(params[:user_id])
  end
end
