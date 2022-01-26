require 'rails_helper'

RSpec.describe FixedCost, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe '固定支出表、入力のテスト' do
    context 'contentの入力が101字以上の場合' do
      it 'バリデーションエラーになる' do
        content = FixedCost.new(content: 'a' * 101, user: user)
        expect(content).to be_invalid
      end
    end
    context '金額を空で入力した時' do
      it 'バリデーションエラーになる' do
        payment = FixedCost.new(payment: '', user: user)
        expect(payment).to be_invalid
      end
    end
    context '金額を大文字で入力した時' do
      it '登録できる' do
        payment = FixedCost.new(payment: '１２３４', user: user)
        expect(payment).to be_valid
      end
    end
    context '金額にマイナスが入力した時' do
      it 'バリデーションエラーになる' do
        payment = FixedCost.new(payment: '-10000', user: user)
        expect(payment).to be_invalid
      end
    end
    context '金額入力欄に数字以外が入力された時' do
      it 'バリデーションエラーになる' do
        payment = FixedCost.new(payment: 'aaaaa', user: user)
        expect(payment).to be_invalid
      end
    end
  end
end
