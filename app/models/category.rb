class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :fixid_costs, through: :categorizations
end
