class Customer < ApplicationRecord
  belongs_to :province

  validates :username, :email, :password, presence: true
end
