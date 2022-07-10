class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :caption
      t.integer :user_id
      t.integer :no_of_reactions, default: 0

      t.timestamps
    end
    add_foreign_key :posts, :users
  end
end
