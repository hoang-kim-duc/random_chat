class AddHobbiesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hobbies, :string, array: true, default: []
  end
end
