class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks.order("category_id")
    @shoppings = @user.shoppings.order("category_id")
    @recipes = @user.recipes.includes(recipe_tags: []).where(release: 1).order("created_at DESC")
    @myrecipes = @user.recipes.includes(recipe_tags: []).order("created_at DESC")
  end
end
