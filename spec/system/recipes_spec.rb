require 'rails_helper'

RSpec.describe "レシピ新規投稿", type: :system do
  before do
    @recipe = FactoryBot.create(:recipe)
    
  end

  context 'レシピ新規投稿ができるとき' do
    it '正しい情報を入力すればレシピ新規投稿ができてmyページに移動する' do
      # ログインする
      sign_in(@recipe.user)
      # トップページに移動する
      visit root_path
      # トップページにレシピ投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('レシピ投稿')
      # 投稿ページに移動する
      visit new_recipe_path
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file('recipe[image]', image_path, make_visible: true)
      # レシピ情報を入力する
      fill_in 'レシピのタイトル', with: @recipe.title
      fill_in '材料', with: @recipe.food
      fill_in '人数', with: @recipe.people
      fill_in '作り方', with: @recipe.making
      fill_in 'レシピ紹介・アドバイス', with: @recipe.introduce
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Recipe.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content(@recipe.title)
    end
  end
end
