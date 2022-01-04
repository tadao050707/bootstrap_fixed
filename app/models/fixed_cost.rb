class FixedCost < ApplicationRecord
  validates :payment, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  belongs_to :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  enum monthly_annual: { monthly: 0, annual: 1 }

end
