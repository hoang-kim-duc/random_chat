class ChangeStatusDataTypeUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :status
    add_column :users, :status, :string, default: 'offline'
    change_column :users, :last_online, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
