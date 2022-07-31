class Chat::ConversationsController < ApplicationController
  include Chat::ConversationsControllerDocument

  after_action :mark_all_received_messages
  before_action :load_conversation, only: [:seen_all, :share_profile]

  def index
    scope = Chat::LoadConversations.new(current_user).call
    render json: paging(scope.includes(:users)
                             .order(message_created_at: :desc)), current_user_id: current_user.id
  end

  def seen_all
    current_user.received_messages
                .where(conversation_id: @conversation.id)
                .unread.each(&:recipent_read!)
  end

  def share_profile
    user_conversation = @conversation.user_conversations.find { |uc| uc.user_id == current_user.id }
    user_conversation.share_profile!
    partner = @conversation.users.find {|user| user.id != current_user.id}
    @conversation.messages.create!(recipient_id: current_user.id, is_system_message: true,
      text: SystemVar.requested_share_profile(partner.name), status: "sent").broadcast!
    @conversation.messages.create!(recipient_id: partner.id, is_system_message: true,
      text: SystemVar.partner_shared_profile(current_user.name), status: "sent").broadcast!
    render json: {success: true}, status: :ok
  # rescue AASM::InvalidTransition
  #   render json: {success: false, error: 'You already requested to share profile'}, status: :bad_request
  end

  private

  def load_conversation
    return if @conversation = Conversation.find(params[:conversation_id])

    render json: {error: 'conversation is not found'}, status: 401
  end

  def mark_all_received_messages
    current_user.received_messages.sent.each(&:broadcast!)
  end
end
