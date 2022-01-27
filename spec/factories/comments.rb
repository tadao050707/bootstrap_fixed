FactoryBot.define do
  factory :comment do
    content { "ユーザー１からユーザー１へのコメントテスト" }
    send_user { 1 }
    association :user
  end
  factory :comment2, class: Comment do
    content { "ユーザー２からユーザー１へのコメント" }
    send_user { 2 }
    association :user
  end
end
