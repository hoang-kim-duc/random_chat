# frozen_string_literal: true

class AppearanceChannel < ApplicationCable::Channel
  after_unsubscribe :handle_offline

  def subscribed
    # user = User.find(params[:id])
    current_user.go_online!
    stream_from Broadcaster::URL.appearance(current_user.id)
  end

  private

  def handle_offline
    HandleOfflineJob.perform_in(1.seconds.from_now, current_user.id)
  end
end
