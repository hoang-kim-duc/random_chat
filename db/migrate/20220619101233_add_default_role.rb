# frozen_string_literal: true

class AddDefaultRole < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :role, :integer, default: 0
  end
end
