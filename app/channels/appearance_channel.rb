# frozen_string_literal: true

class AppearanceChannel < ApplicationCable::Channel
  after_unsubscribe :handle_offline

  def subscribed
    # user = User.find(params[:id])
    current_user.online!
    stream_for User.find(current_user.id)
  end

  def unsubscribed; end

  private

  def handle_offline
    HandleOfflineJob.perform_in(5.seconds.from_now, current_user.id)
  end
end
