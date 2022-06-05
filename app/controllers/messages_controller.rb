class MessagesController < ApplicationController

  def create
    if message = Message.new(message_params)
      render_json(
        action: 'send_message',
        status: :ok,
      )
      puts "status #{UsersChannel.broadcast_to User.find(36), message_params['text']}"
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
    message_params.merge(sender_id: current_user.id, conversation_id: 1)
  end
end
