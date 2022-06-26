# frozen_string_literal: true

module Chat
  module MessagesControllerDocument
    extend Apipie::DSL::Concern

    api :GET, '/conversations/:conversation_id/messages', 'load messages of a conversation'
    param :page, Integer, require: false
    param :per_page, Integer, require: false
    example <<-EG
    [
      {
        "id": 8,
        "conversation_id": 2,
        "text": "test",
        "status": "sent",
        "created_at": "23:00 25/06/2022",
        "seen_at": null,
        "is_system_message": false
      },
      {
        "id": 9,
        "conversation_id": 2,
        "text": "test",
        "status": "sent",
        "created_at": "23:01 25/06/2022",
        "seen_at": null,
        "is_system_message": false
      },
      {
        "id": 10,
        "conversation_id": 2,
        "text": "test",
        "status": "sent",
        "created_at": "23:06 25/06/2022",
        "seen_at": null,
        "is_system_message": false
      },
      {
        "id": 11,
        "conversation_id": 2,
        "text": "test",
        "status": "sent",
        "created_at": "23:07 25/06/2022",
        "seen_at": null,
        "is_system_message": false
      },
      {
        "id": 12,
        "conversation_id": 2,
        "text": "test",
        "status": "sent",
        "created_at": "23:08 25/06/2022",
        "seen_at": null,
        "is_system_message": false
      }
    ]
    EG
    def index; end

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
