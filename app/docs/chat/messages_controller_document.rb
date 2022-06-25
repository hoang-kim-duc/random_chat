# frozen_string_literal: true

module Chat
  module MessagesControllerDocument
    extend Apipie::DSL::Concern

    api :POST, '/conversations/:conversation_id/message', 'enqueue user'
    example <<-EG
    {
      "action": "send_message",
      "success": true,
      "errors": []
    }
    EG
    def create; end
  end
end
