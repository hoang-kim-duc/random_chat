class MessageSerializer < ApplicationSerializer
  attributes :id, :conversation_id, :sender_id, :recipient_id,
    :text, :status, :created_at, :seen_at, :is_system_message

  def created_at
    process_time(object.created_at)
  end

  def seen_at
    process_time(object.seen_at)
  end
end
