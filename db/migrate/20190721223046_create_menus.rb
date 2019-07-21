class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.references :chef, foreign_key: {to_table: :users}
      t.string :name

      t.timestamps
    end
  end
end
