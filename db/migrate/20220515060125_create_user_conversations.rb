# frozen_string_literal: true

class CreateUserConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_conversations do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.boolean :is_archived, default: false
      t.integer :status, default: 0

      t.timestamps
    end

    add_foreign_key :user_conversations, :users
    add_foreign_key :user_conversations, :conversations
  end
end
