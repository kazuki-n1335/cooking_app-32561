require 'rails_helper'

RSpec.describe Shopping, type: :model do
  before do
    @shopping = FactoryBot.build(:shopping)
  end
  describe '食材登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@shopping).to be_valid
      end
      it '個数が空欄でも新規登録できる' do
        @shopping.num = nil
        expect(@shopping).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it '食材が空欄だと登録できない' do
        @shopping.name = nil
        @shopping.valid?
        expect(@shopping.errors.full_messages).to include('食材を入力してください')
      end
      it '同一ユーザーが同一食材を登録できない' do
        @shopping.save
        another_shopping = FactoryBot.build(:shopping)
        another_shopping.name = @shopping.name
        another_shopping.user = @shopping.user
        another_shopping.valid?
        expect(another_shopping.errors.full_messages).to include('食材はすでに存在します')
      end
      it 'カテゴリーが空欄だと登録できない' do
        @shopping.category_id = 0
        @shopping.valid?
        expect(@shopping.errors.full_messages).to include('カテゴリーを入力してください')
      end
    end
  end
end
