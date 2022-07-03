class ConversationSerializer < ApplicationSerializer
  attributes :id, :status, :partner, :last_message

  def last_message
    object.messages.last.to_h
  end

  def partner
    object.users.select { |user| user.id != @instance_options[:current_user_id] }.first.to_h
  end
end
