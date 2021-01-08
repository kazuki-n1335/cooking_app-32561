class PlansController < ApplicationController
  before_action :authenticate_user!
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
    
  end

  def destroy
    
  end

  private
  def plan_params
    params.require(:plan).permit(:people, :date).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end
end
