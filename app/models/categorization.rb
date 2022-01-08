class Categorization < ApplicationRecord
  belongs_to :category
  belongs_to :fixed_cost#, dependent: :destroy
end
