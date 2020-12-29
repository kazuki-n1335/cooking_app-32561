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
    end
    context '新規登録がうまくいかないとき' do
      it '食材が空欄だと登録できない' do
        @stock.food = nil
        @stock.valid?
        expect(@stock.errors.full_messages).to include('食材を入力してください')
      end
      it '同一ユーザーが同一食材を登録できない' do
        @stock.save
        another_stock = FactoryBot.build(:stock)
        another_stock.food = @stock.food
        another_stock.user = @stock.user
        another_stock.valid?
        expect(another_stock.errors.full_messages).to include('Foodはすでに存在します')
      end
      it '個数が空欄だと登録できない' do
        @stock.num = nil
        @stock.valid?
        expect(@stock.errors.full_messages).to include('個数は数値で入力してください')
      end
      it '個数がマイナスだと登録できない' do
        @stock.num = -1
        @stock.valid?
        expect(@stock.errors.full_messages).to include('個数は0以上の値にしてください')
      end
      it '個数が全角だと登録できない' do
        @stock.num = "３"
        @stock.valid?
        expect(@stock.errors.full_messages).to include('個数は数値で入力してください')
      end
    end
  end
end
