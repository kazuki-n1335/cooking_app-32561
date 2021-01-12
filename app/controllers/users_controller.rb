class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks.order("category_id")
    @shoppings = @user.shoppings.order("category_id")
    @recipes = @user.recipes.includes(recipe_tags: []).where(release: 1).order("created_at DESC").page(params[:page]).per(10)
    @myrecipes = @user.recipes.includes(recipe_tags: []).order("created_at DESC").page(params[:page]).per(10)
    @plans = @user.plans.includes(:recipe).order("date")
    likes = Like.where(user_id: current_user.id).pluck(:recipe_id)
    @like_recipes = Recipe.where(id: likes).includes(recipe_tags: []).order("created_at DESC").page(params[:page]).per(10)
  end
end
