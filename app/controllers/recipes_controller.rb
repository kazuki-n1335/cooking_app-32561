class RecipesController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @recipes = Recipe.includes([:user, recipe_tags: []]).where(release: 1).order("created_at DESC")
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    tag_list = params[:recipe][:tag].split(",")
    if @recipe.save
      @recipe.save_tags(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @tags = @recipe.recipe_tags.all
    @comment = Comment.new
    @comments= @recipe.comments.includes(:user)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :title, :people, :food, :making, :introduce, :release).merge(user_id: current_user.id)
  end
end
