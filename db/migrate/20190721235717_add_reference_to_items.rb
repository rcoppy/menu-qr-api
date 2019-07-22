class AddReferenceToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :chef, foreign_key: {to_table: :users}
  end
end
