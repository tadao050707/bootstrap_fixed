FactoryBot.define do
  factory :fixed_cost do
    payment { 60000 }
    monthly_annual { 0 }
    content { '家賃' }
  end
  factory :fixed_cost2, class: FixedCost do
    payment { 10000 }
    monthly_annual { 0 }
    content { '生命保険' }
  end
  factory :fixed_cost3, class: FixedCost do
    payment { 40000 }
    monthly_annual { 1 }
    content { '自動車保険' }
  end
end
