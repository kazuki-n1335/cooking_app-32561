class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks.order("category_id")
    @shoppings = @user.shoppings.order("category_id")
  end
end
