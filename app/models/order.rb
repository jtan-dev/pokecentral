class Order < ApplicationRecord
  has_many :product_orders
  has_many :products, through: :product_orders
  belongs_to :customer

  validates :status, :tax, :total, presence: true
  validates :tax, numericality: { is_numeric: true, greater_than_or_equal_to: 0 }
end
