class CreateItemMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :items_menus do |t|
      t.references :menu, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
