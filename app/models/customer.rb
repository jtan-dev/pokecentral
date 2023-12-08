class Customer < ApplicationRecord
  belongs_to :province

  validates :username, :email, presence: true
end
