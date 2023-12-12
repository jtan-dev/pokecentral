class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  belongs_to :province

  validates :email, presence: true
  validate :postal_code_length

  private

  def postal_code_length
    errors.add(:postal_code, 'must have either 0 or 6 characters') unless [0, 6].include?(postal_code.to_s.length)
  end
end
