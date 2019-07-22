class ItemsMenu < ApplicationRecord
  belongs_to :menu
  belongs_to :item
end
