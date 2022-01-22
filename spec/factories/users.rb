FactoryBot.define do
  factory :user do
    name { 'テストユーザー１' }
    email { 'admin@test.com' }
    password { 'testuser' }
    password_confirmation { 'testuser' }
    admin { true }
  end

  factory :user_b, class: User do
    name { 'テストユーザー２' }
    email { 'test2@test.com' }
    password { 'testuser' }
    password_confirmation { 'testuser' }
    admin { false }
  end

  factory :user_c, class: User do
    name { 'テストユーザー３' }
    email { 'test3@test.com' }
    password { 'testuser' }
    password_confirmation { 'testuser' }
    admin { false }
  end
end
