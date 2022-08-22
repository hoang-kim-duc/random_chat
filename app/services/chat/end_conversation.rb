module Chat
  class EndConversation < BaseService
    def initialize(current_user, conversation)
      @current_user = current_user
      @conversation = conversation
    end

    def call
      partner = @conversation.users.find {|user| user.id != current_user.id}
      ActiveRecord::Base.transaction do
        @conversation.messages.create!(recipient_id: current_user.id, is_system_message: true,
          text: SystemVar.close_conversation(partner.name), status: "sent").broadcast!
        @conversation.messages.create!(recipient_id: partner.id, is_system_message: true,
          text: SystemVar.partner_close_conversation(current_user.name), status: "sent").broadcast!
        @conversation.close!
      end
    end
  end
end
