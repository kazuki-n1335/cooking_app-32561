require 'rails_helper'

describe Food do
  before do
    @food = FactoryBot.build(:food)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@food).to be_valid
      end
      it 'が空欄でも登録できる' do
        @food.time = nil
        expect(@food).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it '食材が空欄だと登録できない' do
        @food.name = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('食材を入力してください')
      end
      it '食材がすでに存在すると登録できない' do
        @food.save
        another_food = FactoryBot.build(:food)
        another_food.name = @food.name
        another_food.valid?
        expect(another_food.errors.full_messages).to include('食材はすでに存在します')
      end
      it 'カテゴリーが空欄だと登録できない' do
        @food.food_tag_id = 0
        @food.valid?
        expect(@food.errors.full_messages).to include('カテゴリーを入力してください')
      end
      it '数え方が空欄だと登録できない' do
        @food.unit_id = 0
        @food.valid?
        expect(@food.errors.full_messages).to include('数え方を入力してください')
      end
      it '保存日数が少数だと登録できない' do
        @food.time = 9.5
        @food.valid?
        expect(@food.errors.full_messages).to include('保存日数は整数で入力してください')
      end
      it '保存日数が数字以外だと登録できない' do
        @food.time = "hello"
        @food.valid?
        expect(@food.errors.full_messages).to include('保存日数は数値で入力してください')
      end
    end
  end
end
