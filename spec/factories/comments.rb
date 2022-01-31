FactoryBot.define do
  factory :comment1, class: Comment do
    content { "ユーザー１からユーザー１へのコメントテスト" }
  end

  factory :comment2, class: Comment do
    content { "ユーザー２からユーザー１へのコメント" }
  end
end
