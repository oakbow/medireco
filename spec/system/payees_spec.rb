require 'rails_helper'

describe '支払先の登録', type: :system do
  let!(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }

  before do
    visit login_path
    fill_in 'メールアドレス', with: 'maguro@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  it '支払先が登録できる' do
    click_link 'ユーザ情報'
    click_link '支払先の一覧'
    click_link '新規登録'
    fill_in '支払先の名前', with: 'おさかな病院'
    click_button '登録'
    expect(page).to have_content 'おさかな病院 を登録しました'
  end

  context '支払先が登録されているとき' do
    before do
      FactoryBot.create(:payee, name: 'おさかな病院', user: user)
      click_link 'ユーザ情報'
      click_link '支払先の一覧'
    end

    it '支払先が閲覧できる' do
      expect(page).to have_content 'おさかな病院' 
    end

    it '支払先が変更できる' do
      click_link '編集'
      fill_in '支払先の名前', with: 'かわざかな薬局'
      click_button '登録'
      expect(page).to have_content 'かわざかな薬局 を更新しました'
    end

    it '支払先が削除できる' do
      click_link '削除'
      expect(page).to have_content 'おさかな病院 を削除しました'
    end
  end
end
