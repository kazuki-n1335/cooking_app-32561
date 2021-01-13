class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks.order("category_id")
    @shoppings = @user.shoppings.order("category_id")
    @recipes = @user.recipes.includes(recipe_tags: []).where(release: 1).order("updated_at DESC").page(params[:page]).per(8)
    @myrecipes = @user.recipes.includes(recipe_tags: []).order("updated_at DESC").page(params[:user_recipe]).per(6)
    @plans = @user.plans.includes(:recipe).order("date")
    likes = Like.where(user_id: current_user.id).pluck(:recipe_id)
    @like_recipes = Recipe.where(id: likes).includes(recipe_tags: []).order("updated_at DESC").page(params[:recipe_like]).per(6)
  end
end
