class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def index
    @stock = Stock.new
    @stocks = @user.stocks.includes(:food).order("foods.food_tag_id")
    @exception = @stocks.pluck(:food_id)
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.food.present? && @stock.food.unit.id == 3
      @stock.num = 1
    end
    if @stock.save
      redirect_to user_path(current_user.id)
    else
      @stocks = @user.stocks.includes(:food).order("foods.food_tag_id")
      render :index
    end
  end

  def update
    @stock = Stock.find(params[:id])
    @stock.update(stock_params)
    if @stock.save
      redirect_to user_path(current_user.id)
    else
      @stocks = @user.stocks.includes(:food).order("foods.food_tag_id")
      render :index
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    if@stock.destroy
      redirect_to user_path(current_user.id)
    else
      @stocks = @user.stocks.includes(:food).order("foods.food_tag_id")
      render :index
    end
  end

  private
  def stock_params
    params.require(:stock).permit(:num, :food_id).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to user_path(@user.id) if current_user.id != @user.id
  end
end
