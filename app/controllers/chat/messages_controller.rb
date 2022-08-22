# frozen_string_literal: true
module Chat
  class MessagesController < ApplicationController
    include Chat::MessagesControllerDocument

    before_action :load_conversation, :check_current_user_in_conversation
    before_action :check_recipient_in_conversation, only: :create
    # after_action :mark_all_received_messages

    def index
      current_user.received_messages
        .where(conversation_id: @conversation.id)
        .unread.each(&:recipent_read!)
      render json: paging(@conversation.messages.order(created_at: :desc)), viewer: current_user
    end

    def create
      if message = @conversation.messages.create(message_params)
        message.broadcast!
        return render_json(
          action: 'send_message',
          status: :ok
        )
      else
        render_json(
          action: 'send_message',
          status: :bad_request,
          content: {
            success: false,
            errors: message.errors.full_messages
          }
        )
      end
    end

    private

    def message_params
      @message_params ||= params.permit(:text, :recipient_id, :uuid, :attachment).merge(sender_id: current_user.id)
    end

    def load_conversation
      @conversation = Conversation.find_by(id: params[:conversation_id])
      return if @conversation

      render_json(
        status: :bad_request,
        content: {
          success: false,
          errors: ["conversation with id #{params[:conversation_id]} is not exist"]
        }
      )
    end

    def check_recipient_in_conversation
      return if @conversation.user_ids.include?(message_params[:recipient_id].to_i)

      render_json(
        status: :bad_request,
        content: {
          success: false,
          errors: ["the recipient is not in this conversation"]
        }
      )
    end

    def check_current_user_in_conversation
      return if @conversation.user_ids.include?(current_user.id)

      render_json(
        status: :bad_request,
        content: {
          success: false,
          errors: ["the sender is not in this conversation"]
        }
      )
    end
  end
end
