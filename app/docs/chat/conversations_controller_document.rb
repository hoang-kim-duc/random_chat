# frozen_string_literal: true

module Chat
  module ConversationsControllerDocument
    extend Apipie::DSL::Concern

    api :GET, '/conversations', 'load conversations'
    param :page, Integer, require: false
    param :per_page, Integer, require: false

    def index; end

    api :PUT, '/conversations/:conversation_id/seen', 'seen all messages within conversation'
    def seen_all; end
  end
end
