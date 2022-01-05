class FixedCost < ApplicationRecord
  validates :payment, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  belongs_to :user
  has_many :categories, dependent: :destroy

  # has_many :categorizations, dependent: :destroy
  # has_many :categories, through: :categorizations

  enum monthly_annual: { monthly: 0, annual: 1 }

  def payment=(value)
    value.tr!('０-９', '0-9') if value.is_a?(String)
    super(value)
  end
end
