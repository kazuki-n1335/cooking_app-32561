class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @recipe = Recipe.find(params[:recipe_id])
    if @recipe.user_id != current_user.id   # 自分の投稿以外にお気に入り登録が可能
      @like = Like.create(user_id: current_user.id, recipe_id: @recipe.id)
    end
  end
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @like = Like.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    @like.destroy
  end
end
