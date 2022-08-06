class AddLocationToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :location, :string
  end
end
