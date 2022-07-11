class ConversationSerializer < ApplicationSerializer
  attributes :id, :status, :partner, :last_message

  def last_message
    message = object.messages.last
    return nil unless message

    if message.is_system_message && message.recipient_id != @instance_options[:current_user_id]
      object.messages.second_to_last
    else
      message.to_h
    end
  end

  def partner
    object.users.select { |user| user.id != @instance_options[:current_user_id] }.first.to_h(viewer: @instance_options[:viewer])
  end
end
