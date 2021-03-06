class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to recipe_path(@comment.recipe) # 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
    else
      @recipe = @comment.recipe
      @comments = @recipe.comments.page(params[:page]).per(5)
      @tags = @recipe.recipe_tags.all
      @plan = Plan.new
      render "recipes/show" 
    end
  end
  

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end
end
