class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :chef
  has_many :items, through: :item_order
end
