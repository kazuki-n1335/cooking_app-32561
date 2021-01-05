class RecipesController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    tag_list = params[:tag].split(",")    
    if @recipe.save
      redirect_to root_path
      @recipe.save_tags(tag_list)
    else
      render :new
    end

  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :title, :people, :food, :making, :introduce, :release).merge(user_id: current_user.id)
  end
end
