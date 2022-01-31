require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'ユーザー新規登録テスト' do
    context '名前、Eメール、パスワードが入力された場合' do
      it '新規アカウント登録ができる' do
        user = FactoryBot.build(:user1)
        expect(user).to be_valid
      end
    end
    context '名前が入力されなかった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, name: nil)
        expect(user).to be_invalid
      end
    end
    context '名前が21字以上の場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, name: 'a' * 21)
        expect(user).to be_invalid
      end
    end
    context 'Emailが入力されなかった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, email: nil)
        expect(user).to be_invalid
      end
    end
    context 'Emailの形式が異なった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, email: 'aaaaaaemailcom')
        expect(user).to be_invalid
      end
    end
    context 'プロフィールが256字以上の場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, profile: 'a' * 256)
        expect(user).to be_invalid
      end
    end
    context 'パスワードが無かった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, password: '')
        expect(user).to be_invalid
      end
    end
    context 'パスワードが５字以下の場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, password: 'aaaaa')
        expect(user).to be_invalid
      end
    end
    context '大人の人数がマイナスの場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user1, adult_number: -1)
        expect(user).to be_invalid
      end
    end
  end
end
