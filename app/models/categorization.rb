class Categorization < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :fixed_cost
end
