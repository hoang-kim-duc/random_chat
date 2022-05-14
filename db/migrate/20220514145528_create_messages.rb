class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :conversation_id
      t.integer :status, default: 0
      t.integer :tag, default: 0

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :recipient_id
    add_foreign_key :messages, :conversations
  end
end
