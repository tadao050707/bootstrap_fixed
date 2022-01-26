require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'ユーザー新規登録テスト' do
    context '名前、Eメール、パスワードが入力された場合' do
      it '新規アカウント登録ができる' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end
    context '名前が入力されなかった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).to be_invalid
      end
    end
    context '名前が21字以上の場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, name: 'a' * 21)
        expect(user).to be_invalid
      end
    end
    context 'Emailが入力されなかった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, email: nil)
        expect(user).to be_invalid
      end
    end
    context 'Emailの形式が異なった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, email: 'aaaaaaemailcom')
        expect(user).to be_invalid
      end
    end
    context 'プロフィールが256字以上の場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, profile: 'a' * 256)
        expect(user).to be_invalid
      end
    end
    context 'パスワードが無かった場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, password: '')
        expect(user).to be_invalid
      end
    end
    context 'パスワードが５字以下の場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, password: 'aaaaa')
        expect(user).to be_invalid
      end
    end
    context '大人の人数がマイナスの場合' do
      it 'バリデーションエラーになる' do
        user = FactoryBot.build(:user, adult_number: -1)
        expect(user).to be_invalid
      end
    end
  end
end
