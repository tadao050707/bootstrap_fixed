# require 'FactoryBot'

user1 = User.create!(name: "test管理者", email: "admin@test.com", password: "testuser", profile: '管理者です', adult_number: 2, child_number: 1, admin: true)

4.times do |n|
  User.create!(
    name: "テストユーザー#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "testuser",
    profile: "#{n + 1}です。よろしくお願いします。",
    adult_number: "#{n + 1}",
    child_number: "#{n + 1}"
  )
end

User.all.each do |user|
  cat1 = user.categories.create!(cat_name: "住宅費")
  cat2 = user.categories.create!(cat_name: "光熱費")
  cat3 = user.categories.create!(cat_name: "通信費")
  cat4 = user.categories.create!(cat_name: "保険")
  cat5 = user.categories.create!(cat_name: "養育費")

  cost1 = user.fixed_costs.create!(payment: rand(80000..120000), monthly_annual: 0, content: "家賃")
  Categorization.create!(category_id: cat1.id, fixed_cost_id: cost1.id)
  cost2 = user.fixed_costs.create!(payment: rand(3000..12000), monthly_annual: 0, content: "電気代")
  Categorization.create!(category_id: cat2.id, fixed_cost_id: cost2.id)
  cost3 = user.fixed_costs.create!(payment: rand(1000..9000), monthly_annual: 0, content: "スマホ代")
  Categorization.create!(category_id: cat3.id, fixed_cost_id: cost3.id)
  cost4 = user.fixed_costs.create!(payment: rand(24000..120000), monthly_annual: 1, content: "生命保険")
  Categorization.create!(category_id: cat4.id, fixed_cost_id: cost4.id)
  cost5 = user.fixed_costs.create!(payment: rand(5000..50000), monthly_annual: 0, content: "塾")
  Categorization.create!(category_id: cat5.id, fixed_cost_id: cost5.id)
end

user2 = User.find(2)
user3 = User.find(3)
user4 = User.find(4)
user5 = User.find(5)

user1.comments.create!(content: "ユーザー１からアドミンユーザー１へのコメントテスト", send_user: 2)
user1.comments.create!(content: "ユーザー２からアドミンユーザー１へのコメントテスト", send_user: 3)
user4.comments.create!(content: "ユーザー3からユーザー4へのテストコメント", send_user: 5)
