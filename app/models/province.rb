class Province < ApplicationRecord
  has_many :customers

  validates :tax_percentage, numericality: { greater_than_or_equal_to: 0 }
  validates :full_name, :code, :tax_percentage, presence: true
end
