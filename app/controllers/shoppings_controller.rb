class ShoppingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def index
    @shopping = Shopping.new
    @shoppings = @user.shoppings.order("category_id")
  end

  def create
    @shopping = Shopping.new(shopping_params)
    if @shopping.save
      redirect_to user_path(current_user.id)
    else
      @shoppings = @user.shoppings.order("category_id")
      render :index
    end
  end

  def update
    @shopping = Shopping.find(params[:id])
    name = @shopping.name
    @shopping.update(shopping_params)
    if @shopping.save
      redirect_to user_path(current_user.id), notice: "#{name}の個数を変更しました"
    else
      @shoppings = @user.shoppings.order("category_id")
      flash.now[:alert] = "変更に失敗しました。"
      render :index
    end
  end

  def destroy
    @shopping = Shopping.find(params[:id])
    name = @shopping.name
    @shopping.destroy
    if@shopping.destroy
      redirect_to user_path(current_user.id), notice: "#{name}を削除しました"
    else
      @shoppings = @user.shoppings.order("category_id")
      flash.now[:alert] = "変更に失敗しました。"
      render :index
    end
  end

  private
  def shopping_params
    params.require(:shopping).permit(:num, :name, :category_id).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to user_path(@user.id) if current_user.id != @user.id
  end
end
