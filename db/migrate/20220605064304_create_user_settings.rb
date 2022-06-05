class CreateUserSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_settings do |t|
      t.integer :from_age
      t.integer :to_age
      t.float :lat
      t.float :long
      t.string :address
      t.integer :range
      t.integer :gender
      t.integer :user_id
      t.boolean :enable_age_filter, default: false
      t.boolean :enable_location_filter, default: false
      t.boolean :enable_gender_filter, default: false

      t.timestamps
    end
  end
end
