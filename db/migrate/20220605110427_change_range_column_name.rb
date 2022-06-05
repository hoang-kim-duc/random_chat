class ChangeRangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_settings, :range, :radius
  end
end
