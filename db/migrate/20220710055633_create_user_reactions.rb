class CreateUserReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reactions do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_foreign_key :user_reactions, :posts
    add_foreign_key :user_reactions, :users
  end
end
