FactoryBot.define do
  factory :category do
    cat_name { '住宅費' }
  end
  factory :category2, class: Category do
    cat_name { '保険' }
  end
  factory :category3, class: Category do
    cat_name { '自動車関係'}
  end
end
