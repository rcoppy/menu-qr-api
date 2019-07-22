class Menu < ApplicationRecord
  belongs_to :chef
  has_many :items, through: :item_menu
end
