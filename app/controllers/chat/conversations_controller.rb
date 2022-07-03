class Chat::ConversationsController < ApplicationController
  # def create
  #   Conversation.create(user_conversations_attributes: conversation_params.map do |user_id|
  #     {user_id: user_id}
  #   end)
  # end

  def index
    render json: paging(current_user.conversations
                                    .includes(:users, :messages)
                                    .order(created_at: :desc)), current_user_id: current_user.id
  end

  # private

  # def conversation_params
  #   @conversation_params ||= params.require(:conversation).permit(:user_ids)
  # end
end
