class Menu < ApplicationRecord
  belongs_to :chef, class_name: "User"
  has_many :items_menus
  has_many :items, through: :items_menus
end
