class ChangeStatusDataTypeConversations < ActiveRecord::Migration[7.0]
  def change
    remove_column :conversations, :status
    add_column :conversations, :status, :string, default: "openning"
  end
end
