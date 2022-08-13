class MessageSerializer < ApplicationSerializer
  attributes :id, :conversation_id, :sender_id, :recipient_id,
    :text, :status, :created_at, :seen_at, :is_system_message, :attachment_path

  def created_at
    process_time(object.created_at, @instance_options[:viewer])
  end

  def seen_at
    process_time(object.seen_at, @instance_options[:viewer])
  end
end
