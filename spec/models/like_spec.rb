require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end
  describe 'お気に入り登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@like).to be_valid
      end
    end
  
    context '新規登録がうまくいかないとき' do
      it 'userが紐付いていないと保存できないこと' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'recipeが紐付いていないと保存できないこと' do
        @like.recipe = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('レシピを入力してください')
      end
      it '同じユーザーが同じレシピをお気に入り登録できないこと' do
        @like.save
        another_like = FactoryBot.build(:like)
        another_like.recipe = @like.recipe
        another_like.user = @like.user
        another_like.valid?
        expect(another_like.errors.full_messages).to include('Userはすでに存在します')
      end
    end
  end
end
