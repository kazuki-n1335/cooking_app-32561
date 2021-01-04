require 'rails_helper'

RSpec.describe Stock, type: :model do
  before do
    @stock = FactoryBot.build(:stock)
  end
  describe '食材登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@stock).to be_valid
      end
      it '個数が空欄でも新規登録できる' do
        @stock.num = nil
        expect(@stock).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it '食材が空欄だと登録できない' do
        @stock.name = nil
        @stock.valid?
        expect(@stock.errors.full_messages).to include('食材を入力してください')
      end
      it '同一ユーザーが同一食材を登録できない' do
        @stock.save
        another_stock = FactoryBot.build(:stock)
        another_stock.name = @stock.name
        another_stock.user = @stock.user
        another_stock.valid?
        expect(another_stock.errors.full_messages).to include('食材はすでに存在します')
      end
      it 'カテゴリーが空欄だと登録できない' do
        @stock.category_id = 0
        @stock.valid?
        expect(@stock.errors.full_messages).to include('カテゴリーを入力してください')
      end
    end
  end
end
