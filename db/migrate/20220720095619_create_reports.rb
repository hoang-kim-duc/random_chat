class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.integer :problem_type
      t.string :text
      t.string :target_type
      t.integer :target_id
      t.integer :owner_id
      t.string :status

      t.timestamps
    end
  end
end
