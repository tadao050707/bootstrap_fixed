FactoryBot.define do
  factory :fixed_cost do
    payment { '1000000' }
    monthly_annual { '1' }
    content { '定額積み立て保険' }
    association :user
  end
end
