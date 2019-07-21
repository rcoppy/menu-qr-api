class Menu < ApplicationRecord
  belongs_to :chef_id
  has_many :items, through: :item_menu
end
