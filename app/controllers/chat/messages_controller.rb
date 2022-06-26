# frozen_string_literal: true
module Chat
  class MessagesController < ApplicationController
    include Chat::MessagesControllerDocument

    def create
      conversation = Conversation.find_by(id: params[:conversation_id])
      errors = []
      if conversation
        errors << "the sender is not in this conversation" unless conversation.user_ids.include?(current_user.id)
        errors << "the recipient is not in this conversation" unless conversation.user_ids.include?(message_params[:recipient_id].to_i)
      else
        errors << "conversation with id #{params[:conversation_id]} is not exist"
      end

      if errors.empty?
        if message = conversation.messages.create(message_params)
          message.broadcast!
          return render_json(
            action: 'send_message',
            status: :ok
          )
        else
          errors = message&.errors&.full_messages
        end
      end

      render_json(
        action: 'send_message',
        status: :bad_request,
        content: {
          success: false,
          errors: errors
        }
      )
    end

    private

    def message_params
      @message_params ||= params.require(:message).permit(:text, :recipient_id).merge(sender_id: current_user.id)
    end
  end
end
