# frozen_string_literal: true
module Chat
  class MessagesController < ApplicationController
    include Chat::MessagesControllerDocument

    def create
      if message = Message.create(message_params)
        message.broadcast!
        render_json(
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
      message_params = params.require(:message).permit(:text, :recipient_id)
      message_params.merge(sender_id: current_user.id, conversation_id: params[:conversation_id])
    end
  end
end
