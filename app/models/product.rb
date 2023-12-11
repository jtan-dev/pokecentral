class Product < ApplicationRecord
  has_many :product_orders
  has_many :orders, through: :product_orders
  belongs_to :category

  validates :name, :price, :description, presence: true
  validates :price, numericality: { is_numeric: true, greater_than_or_equal_to: 0 }
  validates :name, uniqueness: true
  validates :stock, numericality: { is_numeric: true, greater_than_or_equal_to: 0 }

  has_one_attached :image
end
