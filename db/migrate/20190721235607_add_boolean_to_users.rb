class AddBooleanToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_chef, :boolean
  end
end
