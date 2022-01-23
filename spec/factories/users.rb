FactoryBot.define do
  factory :user do
    name { 'テストユーザー１' }
    email { 'admin@test.com' }
    password { 'testuser' }
    password_confirmation { 'testuser' }
    admin { true }
  end

  factory :user2, class: User do
    name { 'テストユーザー２' }
    email { 'test2@test.com' }
    password { 'testuser' }
    password_confirmation { 'testuser' }
    admin { false }
  end

  factory :user3, class: User do
    name { 'テストユーザー３' }
    email { 'test3@test.com' }
    password { 'testuser' }
    password_confirmation { 'testuser' }
    admin { false }
  end
end
