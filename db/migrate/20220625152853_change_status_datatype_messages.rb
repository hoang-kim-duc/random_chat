class ChangeStatusDatatypeMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :status
    add_column :messages, :status, :string, default: "sent"
  end
end
