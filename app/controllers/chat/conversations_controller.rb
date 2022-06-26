class Chat::ConversationsController < ApplicationController
  def create
    Conversation.create(user_conversations_attributes: conversation_params.map do |user_id|
      {user_id: user_id}
    end)
  end

  private

  def conversation_params
    @conversation_params ||= params.require(:conversation).permit(:user_ids)
  end
end
