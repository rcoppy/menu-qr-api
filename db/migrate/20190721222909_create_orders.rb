class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: {to_table: :users}
      t.references :chef, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
