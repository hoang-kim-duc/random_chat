# frozen_string_literal: true

module Chat
  module MessagesControllerDocument
    extend Apipie::DSL::Concern

    api :POST, '/conversations/:conversation_id/messages', 'send message to user in conversation'
    param :message, Hash, require: true do
      param :text, String, require: true
      param :recipient_id, Integer, require: true
    end
    example <<-EG
    {
      "action": "send_message",
      "success": true,
      "errors": []
    }
    EG
    example <<-EG
    {
      "action": "send_message",
      "success": false,
      "errors": [
        "the recipient is not in this conversation"
      ]
    }
    EG
    def create; end
  end
end
