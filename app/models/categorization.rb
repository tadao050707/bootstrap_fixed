class Categorization < ApplicationRecord
  belongs_to :fixed_cost, dependent: :destroy
  belongs_to :category
end
