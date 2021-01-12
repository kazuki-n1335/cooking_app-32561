class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_show, only: [:edit, :update, :destroy]
  def index
    @recipes = Recipe.includes([:user, recipe_tags: []]).where(release: 1).order("created_at DESC").page(params[:page]).per(10)
    @tags = RecipeTag.includes(recipes: []).order("tag").page(params[:page]).per(30)
  end

  def new
    @recipe = Recipe.new
    @tag_list = nil
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
    @plan = Plan.new
    @comments= @recipe.comments.includes(:user).page(params[:page]).per(5)
  end

  def destroy
    @recipe.destroy
    if @recipe.destroy
      redirect_to user_path(current_user.id)
    else
      render :show
    end
  end

  def edit
    @tag_list = @recipe.recipe_tags.pluck(:tag).join(",")
  end

  def update
    tag_list = params[:recipe][:tag].split(",")
    if @recipe.valid?
      @recipe.update(recipe_params)
      @recipe.save_tags(tag_list)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :title, :people, :food, :making, :introduce, :release).merge(user_id: current_user.id)
  end

  def move_to_show
    @recipe = Recipe.find(params[:id])
    if current_user.id != @recipe.user_id
      redirect_to recipe_path(@recipe.id)
    end
  end
end
