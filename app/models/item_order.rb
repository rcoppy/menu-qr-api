class ItemOrder < ApplicationRecord
  belongs_to :order_id
  belongs_to :item_id
end
