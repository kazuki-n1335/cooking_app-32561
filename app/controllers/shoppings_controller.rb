class ShoppingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def index
    @shopping = Shopping.new
    @shoppings = @user.shoppings.includes(:food).order("foods.food_tag_id")
    @exception = @shoppings.pluck(:food_id)
  end

  def create
    @shopping = Shopping.new(shopping_params)
    if @shopping.food.present? && @shopping.food.unit.id == 3
      @shopping.num = 1
    end
    if @shopping.save
      redirect_to user_path(current_user.id)
    else
      @shoppings = @user.shoppings.includes(:food).order("foods.food_tag_id")
      render :index
    end
  end

  def update
    @shopping = Shopping.find(params[:id])
    @shopping.update(shopping_params)
    if @stock.save
      redirect_to user_path(current_user.id)
    else
      @shoppings = @user.shoppings.includes(:food).order("foods.food_tag_id")
      render :index
    end
  end

  def destroy
    @shopping = Shopping.find(params[:id])
    @shopping.destroy
    if@shopping.destroy
      redirect_to user_path(current_user.id)
    else
      @shoppings = @user.shoppings.includes(:food).order("foods.food_tag_id")
      render :index
    end
  end

  private
  def shopping_params
    params.require(:shopping).permit(:num, :food_id).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to user_path(@user.id) if current_user.id != @user.id
  end
end
