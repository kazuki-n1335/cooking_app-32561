require 'rails_helper'

RSpec.describe RecipeTag, type: :model do
  before do
    @recipe_tag = FactoryBot.build(:recipe_tag)
  end
  describe '食材登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@recipe_tag).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'tagが空欄だと登録できない' do
        @recipe_tag.tag = nil
        @recipe_tag.valid?
        expect(@recipe_tag.errors.full_messages).to include('レシピタグを入力してください')
      end
    end
  end
end
