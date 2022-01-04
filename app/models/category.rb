class Category < ApplicationRecord
  validates :cat_name, presence: true, length: { maximum: 8, message: '8文字以内です' }, uniqueness: true

  belongs_to :user
  has_many :categorizations, dependent: :destroy
  has_many :fixid_costs, through: :categorizations
end
