class MessageSerializer < ApplicationSerializer
  attributes :id, :conversation_id, :sender_id, :recipient_id,
    :text, :status, :created_at, :seen_at, :is_system_message, :attachment_path
end
