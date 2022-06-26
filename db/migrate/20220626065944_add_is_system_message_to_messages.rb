class AddIsSystemMessageToMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :tag
    add_column :messages, :is_system_message, :boolean, default: false
  end
end
