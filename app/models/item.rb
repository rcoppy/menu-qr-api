class Item < ApplicationRecord
  belongs_to :chef, class_name: "User"
  has_many :items_menus
  has_many :items_orders
  has_many :menus, through: :items_menus
  has_many :orders, through: :items_orders
end
