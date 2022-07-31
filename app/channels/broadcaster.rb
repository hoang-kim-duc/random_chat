class Broadcaster
  module URL
    def self.method_missing(m, *args)
      "#{m}_#{args[0]}"
    end
  end

  class << self
    [:pairing, :appearance, :new_message, :msg_latest_status,
      :online_status, :conversation_status].each do |channel|
      define_method "broadcast_to_#{channel}" do |user_id, msg|
        ActionCable.server.broadcast(URL.send(channel, user_id), msg)
      end
    end
  end
end
