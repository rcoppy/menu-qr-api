class AddBooleanToMenu < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :is_current, :boolean
  end
end
