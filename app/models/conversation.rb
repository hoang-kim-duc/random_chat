# frozen_string_literal: true

class Conversation < ApplicationRecord
  include AASM

  has_many :messages, dependent: :delete_all
  has_many :user_conversations, dependent: :delete_all
  has_many :users, through: :user_conversations

  accepts_nested_attributes_for :user_conversations, reject_if: lambda { |attributes|
                                                                  attributes['user_id'].blank?
                                                                }, allow_destroy: true

  aasm column: :status do
    state :opening, initial: true
    state :sharing
    state :closed

    event :close do
      transitions from: [:opening, :sharing], to: :closed
    end
  end

  def load_last_message(user_id)
    last_msg = self.messages.where.not("messages.is_system_message = true AND messages.recipient_id != #{user_id}").last
    last_msg.slice(:id, :text, :status, :sender_id, :recipient_id, :created_at)
  end

  private

  # def unique_pair
  #   sql = '
  #     SELECT "temp"."conversation_id", count("temp"."user_id")
  #     FROM (
  #       SELECT "user_conversations"."conversation_id", "user_conversations"."user_id"
  #       FROM "user_conversations" INNER JOIN "conversations"
  #       ON "conversations"."id" = "user_conversations"."conversation_id"
  #       WHERE "user_conversations"."user_id" IN (?)) AS temp
  #     GROUP BY "temp"."conversation_id";'
  #   Conversation.sanitize_sql_array(sql, self.user_ids);
  #   results = ActiveRecord::Base.connection.execute(sql).to_a
  #   unique_pair = true
  #   results.each do |object|
  #     unique_pair = false if object["count"] >= 2
  #   end
  #   errors.add(:base, "user")
  # end

  # def read_all
  #   messages.unread.seen!
  # end
end
