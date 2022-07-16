class Chat::ConversationsController < ApplicationController
  include Chat::ConversationsControllerDocument

  after_action :mark_all_received_messages

  def index
    scope = Chat::LoadConversations.new(current_user).call
    render json: paging(scope.includes(:users)
                             .order(message_created_at: :desc)), current_user_id: current_user.id
  end

  def seen_all
    current_user.received_messages.unread.each(&:recipent_read!)
  end

  private

  def mark_all_received_messages
    current_user.received_messages.sent.each(&:broadcast!)
  end
end
