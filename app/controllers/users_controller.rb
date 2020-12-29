class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks.includes(:food).order("foods.food_tag_id")
  end
end
