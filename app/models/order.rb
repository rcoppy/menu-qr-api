class Order < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :chef, class_name: "User"
  has_many :items_orders
  has_many :items, through: :items_orders
end
