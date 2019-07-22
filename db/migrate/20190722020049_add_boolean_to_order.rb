class AddBooleanToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_completed, :boolean, default: false
    add_column :orders, :is_cancelled, :boolean, default: false
  end
end
