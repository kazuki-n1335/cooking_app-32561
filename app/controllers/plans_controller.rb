class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:create]
  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to user_path(current_user.id)
    else
      @recipe = @plan.recipe
      @comments = @recipe.comments
      @tags = @recipe.recipe_tags.all
      @comment = Comment.new
      render "recipes/show" 
    end
  end

  def update
    @plan.update(plan_params)
    if @plan.save
      redirect_to user_path(current_user.id), notice: "#{@plan.recipe.title}の作成予定内容を変更しました"
    else
      render_mypage
    end
  end

  def destroy
    if @plan.destroy
      redirect_to user_path(current_user.id), notice: "#{@plan.recipe.title}の作成予定を削除しました"
    else
      render_mypage
    end
  end

  private
  def plan_params
    params.require(:plan).permit(:people, :date).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end

  def set_user
    @plan = Plan.find(params[:id])
    redirect_to user_path(@user.id) if current_user.id != @plan.user_id
  end

  def render_mypage
    @user = User.find_by( id: @plan.user_id)
    @stocks = @user.stocks.order("category_id")
    @shoppings = @user.shoppings.order("category_id")
    @recipes = @user.recipes.includes(recipe_tags: []).where(release: 1).order("updated_at DESC").page(params[:page]).per(8)
    @myrecipes = @user.recipes.includes(recipe_tags: []).order("updated_at DESC").page(params[:page]).per(6)
    @plans = @user.plans.includes(:recipe).order("date")
    likes = Like.where(user_id: current_user.id).pluck(:recipe_id)
    @like_recipes = Recipe.where(id: likes).includes(recipe_tags: []).order("updated_at DESC").page(params[:page]).per(6)
    flash.now[:alert] = "変更に失敗しました。"
    render "users/show"
  end
end
