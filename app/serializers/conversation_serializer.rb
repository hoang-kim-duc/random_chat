class ConversationSerializer < ApplicationSerializer
  attributes :id, :status, :partner, :last_message

  def last_message
    {
      id: object.message_id,
      text: object.message_text,
      status: object.message_status,
      sender_id: object.message_sender_id,
      recipient_id: object.message_recipient_id,
      created_at: object.message_created_at
    }
  end

  def partner
    object.users.select { |user| user.id != @instance_options[:current_user_id] }.first.to_h
  end
end
