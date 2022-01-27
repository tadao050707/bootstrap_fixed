FactoryBot.define do
  factory :fixed_cost do
    payment { '1000000' }
    monthly_annual { 0 }
    content { '住宅ローン' }
    association :user
  end

  factory :fixed_cost2, class: FixedCost do
    payment { '33000' }
    monthly_annual { 1 }
    content { '自動車保険' }
    association :user
  end
end
