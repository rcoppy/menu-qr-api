class ItemMenu < ApplicationRecord
  belongs_to :menu_id
  belongs_to :item_id
end
