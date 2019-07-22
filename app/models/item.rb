class Item < ApplicationRecord
  belongs_to :chef, class_name: "User"
  has_many :items_menus
  has_many :items_orders
end
