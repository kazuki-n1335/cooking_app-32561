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
    end
    context '新規登録がうまくいかないとき' do
      it '食材が空欄だと登録できない' do
        @shopping.food = nil
        @shopping.valid?
        expect(@shopping.errors.full_messages).to include('食材を入力してください')
      end
      it '同一ユーザーが同一食材を登録できない' do
        @shopping.save
        another_shopping = FactoryBot.build(:shopping)
        another_shopping.food = @shopping.food
        another_shopping.user = @shopping.user
        another_shopping.valid?
        expect(another_shopping.errors.full_messages).to include('Foodはすでに存在します')
      end
      it '個数が空欄だと登録できない' do
        @shopping.num = nil
        @shopping.valid?
        expect(@shopping.errors.full_messages).to include('個数は数値で入力してください')
      end
      it '個数がマイナスだと登録できない' do
        @shopping.num = -1
        @shopping.valid?
        expect(@shopping.errors.full_messages).to include('個数は0以上の値にしてください')
      end
      it '個数が全角だと登録できない' do
        @shopping.num = "３"
        @shopping.valid?
        expect(@shopping.errors.full_messages).to include('個数は数値で入力してください')
      end
    end
  end
end
