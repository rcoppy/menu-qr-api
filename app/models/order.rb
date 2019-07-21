class Order < ApplicationRecord
  belongs_to :customer_id
  belongs_to :chef_id
  has_many :items, through: :item_order
end
