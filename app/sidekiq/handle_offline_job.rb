# frozen_string_literal: true

class HandleOfflineJob
  include Sidekiq::Job

  queue_as :critical

  def perform(user_id)
    user = User.find(user_id)
    return if user.nil? || user.still_connected?

    user.offline!
  end
end
