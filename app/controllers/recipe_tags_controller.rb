class RecipeTagsController < ApplicationController
  def index
    
  end
  def show
    @tag = RecipeTag.find(params[:id])
    @recipes = @tag.recipes.includes([ :user, recipe_tags: []]).where(release: 1).order("created_at DESC").page(params[:page]).per(10)
  end
end
