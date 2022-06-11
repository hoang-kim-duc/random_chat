class AddStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :status, :integer, default: 0
    add_column :users, :last_online, :datetime, default: 'now()'
  end
end
