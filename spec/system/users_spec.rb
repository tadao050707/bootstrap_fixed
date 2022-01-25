require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }

  describe '新規ユーザー登録' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーが登録される' do
        visit new_user_registration_path
        fill_in 'ユーザーネーム', with: '新規テストユーザー'
        fill_in 'Eメール', with: 'user123@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        click_on 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
  end

end
