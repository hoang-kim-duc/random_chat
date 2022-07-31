class ChangeStatusDataTypeUserConversations < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_conversations, :status
    add_column :user_conversations, :status, :string, default: 'opening'
  end
end
