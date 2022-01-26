require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user2)}

  describe 'カテゴリー入力のテスト' do
    context 'カテゴリーの字数が11字以上の場合' do
      it 'バリデーションエラーになる' do
        category = Category.new(cat_name: 'a' * 11,  user: user)
        expect(category).to be_invalid
      end
    end
  end
  describe '同一ユーザが同じカテゴリー名を登録された時' do
    it 'バリデーションエラーになる' do
      category = Category.create(cat_name: 'a', user: user)
      category2 = Category.create(cat_name: 'a', user: user)
      expect(category2).to be_invalid
    end
  end
  describe '異なるユーザが同じカテゴリー名を登録した時' do
    it '登録できる' do
      category = Category.create(cat_name: 'a', user: user)
      category2 = Category.create(cat_name: 'a', user: user2)
      expect(category2).to be_valid
    end
  end
end
