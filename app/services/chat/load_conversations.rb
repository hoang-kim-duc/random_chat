module Chat
  class LoadConversations < BaseService
    def initialize(current_user)
      @current_user = current_user
      @scope = current_user.conversations
    end

    def call
      add_last_message

      result = @scope
    end

    private

    def last_messages_by_conversation
      return <<-SQL.squish
        WITH excluded_messages AS (
          SELECT *
          FROM messages
          WHERE NOT (messages.is_system_message = true AND messages.recipient_id != #{current_user.id})
        )
        SELECT m1.conversation_id, m1.text as message_text, m1.created_at as message_created_at,
          m1.sender_id as message_sender_id, m1.recipient_id as message_recipient_id,
          m1.status as message_status, m1.id as message_id
        FROM excluded_messages m1
        LEFT JOIN excluded_messages m2
          ON m1.created_at < m2.created_at
          AND m1.conversation_id = m2.conversation_id
          AND m1.conversation_id IN (#{@scope.ids.join(', ')})
        WHERE m2.id IS NULL
      SQL
    end

    def add_last_message
      @scope = @scope.joins("LEFT JOIN (#{last_messages_by_conversation}) m ON m.conversation_id = conversations.id").select("conversations.*, m.*")
    end
  end
end
