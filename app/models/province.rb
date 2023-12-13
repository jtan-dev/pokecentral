class Province < ApplicationRecord
  has_many :customers

  validates :pst, :gst, :hst, numericality: { is_numeric: true, greater_than_or_equal_to: 0 }
  validates :full_name, :code, :pst, :gst, :hst, presence: true
end
