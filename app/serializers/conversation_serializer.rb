class ConversationSerializer < ApplicationSerializer
  attributes :id, :status, :partner, :last_message, :current_user_conversation

  def last_message
    if object.respond_to? :message_id
      {
        id: object.message_id,
        text: object.message_text,
        status: object.message_status,
        sender_id: object.message_sender_id,
        recipient_id: object.message_recipient_id,
        created_at: object.message_created_at
      }
    else
      object.load_last_message(@instance_options[:current_user_id])
    end
  end

  def partner
    object.users.select { |user| user.id != @instance_options[:current_user_id] }.first.to_h
  end

  def current_user_conversation
    object.user_conversations.find { |uc| uc.user_id == @instance_options[:current_user_id] }
  end
end
