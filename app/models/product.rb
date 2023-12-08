class Product < ApplicationRecord
  belongs_to :category

  has_many :product_orders
  has_many :orders, through: :product_orders

  has_one_attached :image
end
