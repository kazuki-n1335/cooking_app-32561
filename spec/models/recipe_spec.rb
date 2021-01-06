require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @recipe = FactoryBot.build(:recipe)
  end
  describe '食材登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@recipe).to be_valid
      end
      it 'レシピ紹介がなくても新規登録できる' do
        @recipe.introduce = nil
        expect(@recipe).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it '画像が空欄だと登録できない' do
        @recipe.image = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('レシピ画像を入力してください')
      end
      it 'タイトルが空欄だと登録できない' do
        @recipe.title = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('レシピタイトルを入力してください')
      end
      it '人数が空欄だと登録できない' do
        @recipe.people = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '人数が11だと登録できない' do
        @recipe.people = 11
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '人数が0だと登録できない' do
        @recipe.people = 0
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '人数が半角数字以外だと登録できない' do
        @recipe.people = "ab"
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '材料が空欄だと登録できない' do
        @recipe.food = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('材料を入力してください')
      end
      it '作り方が空欄だと登録できない' do
        @recipe.making = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('作り方を入力してください')
      end
      it 'レシピ公開が空欄だと登録できない' do
        @recipe.release = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('レシピ公開は一覧にありません')
      end
    end
  end
end
