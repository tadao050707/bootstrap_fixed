class FixedCost < ApplicationRecord
  belongs_to :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  enum monthly_annual: { monthly: 0, annual: 1 }

end
