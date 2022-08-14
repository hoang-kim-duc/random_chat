class RemoveTimeZone < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :time_zone
    remove_column :users, :reported_times
  end
end
