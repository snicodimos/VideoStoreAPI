class Movie < ApplicationRecord
  before_create :set_available_inventory_default
  has_many :rentals, dependent: :nullify

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end
end
