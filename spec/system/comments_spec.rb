require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }
  let(:comment) { FactoryBot.create(:comment, user: user) }
  # let!(:comment2) { FactoryBot.create(:comment2, user: user) }

  describe 'コメントCURD機能テスト' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
      visit user_path(user)
    end
    let!(:login_user) { user }

    context 'コメント投稿した時' do
      # before do
      #   comment.merge!(send_user: 1)
      # end

      it 'コメントが表示される' do
        # find(".cssClassName").set("入力値")
        # find(".cssfield").set("コメントテスト")
        # binding.pry

        fill_in 'comment_content', with: 'コメントのテスト'
        # binding.pry
        click_on '送信'
        expect(page).to have_content 'コメントのテスト'
      end
    end
  end

end
