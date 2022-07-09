class Chat::ConversationsController < ApplicationController
  after_action :mark_all_received_messages

  def index
    render json: paging(current_user.conversations
                                    .includes(:users, :messages)
                                    .order(created_at: :desc)), current_user_id: current_user.id
  end

  def seen_all
    current_user.received_messages.unread.each(&:recipent_read!)
  end

  private

  def mark_all_received_messages
    current_user.received_messages.sent.each(&:broadcast!)
  end
end
