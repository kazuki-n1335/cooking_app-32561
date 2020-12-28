class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def index
    @stock = Stock.new
    @stocks = @user.stocks.includes(:food)
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      redirect_to user_path(current_user.id)
    else
      render :new
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
