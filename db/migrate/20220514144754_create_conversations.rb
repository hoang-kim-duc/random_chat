class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
