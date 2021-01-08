require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメント登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@comment).to be_valid
      end
    end
  
    context '新規登録がうまくいかないとき' do
      it 'コメントが空欄だと登録できない' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントを入力してください')
      end
      it 'userが紐付いていないと保存できないこと' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'レシピが紐付いていないと保存できないこと' do
        @comment.recipe = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('レシピを入力してください')
      end
    end
  end
end
