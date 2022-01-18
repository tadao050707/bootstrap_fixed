FactoryBot.define do
  factory :comment do
    user { nil }
    content { "MyText" }
    send_user { 1 }
  end
end
