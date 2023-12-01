class Customer < ApplicationRecord
  has_many :orders
  belongs_to :province

  validates :username, :password, :email, presence: true
  validates :postal_code, length: { is: 6 }
end
