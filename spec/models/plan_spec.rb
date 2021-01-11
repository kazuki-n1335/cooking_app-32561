require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @plan = FactoryBot.build(:plan)
  end
  describe 'コメント登録' do
    context '新規登録がうまくいくとき' do
      it '正常に記入すると新規登録できる' do
        expect(@plan).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it '日付が空欄だと登録できない' do
        @plan.date = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include('日付を入力してください')
      end
      it '人数が空欄だと登録できない' do
        @plan.people = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '人数が半角数字だと登録できない' do
        @plan.people = "a"
        @plan.valid?
        expect(@plan.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '人数が0以下だと登録できない' do
        @plan.people = 0
        @plan.valid?
        expect(@plan.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it '人数が11以上だと登録できない' do
        @plan.people = 11
        @plan.valid?
        expect(@plan.errors.full_messages).to include('人数が適切な数値ではありません')
      end
      it 'userが紐付いていないと保存できないこと' do
        @plan.user = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'レシピが紐付いていないと保存できないこと' do
        @plan.recipe = nil
        @plan.valid?
        expect(@plan.errors.full_messages).to include('レシピを入力してください')
      end
    end
  end
end
