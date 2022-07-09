# frozen_string_literal: true

class MsgLatestStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from Broadcaster::URL.msg_latest_status(current_user.id)
  end
end
