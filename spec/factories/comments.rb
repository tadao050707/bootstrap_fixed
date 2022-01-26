FactoryBot.define do
  factory :comment do
    # user { nil }
    content { "テストコメント１" }
    # send_user { 1 }
  end
  factory :comment2, class: Comment do
    content { "コメントテスト２" }
  end
end
