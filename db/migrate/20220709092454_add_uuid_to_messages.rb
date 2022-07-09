class AddUuidToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :uuid, :string
  end
end
