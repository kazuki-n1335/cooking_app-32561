class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def index
    @stock = Stock.new
    @stocks = @user.stocks.order("category_id")
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      redirect_to user_path(current_user.id)
    else
      @stocks = @user.stocks.order("category_id")
      render :index
    end
  end

  def update
    @stock = Stock.find(params[:id])
    name = @stock.name
    @stock.update(stock_params)
    if @stock.save
      redirect_to user_path(current_user.id), notice: "#{name}の個数を変更しました"
    else
      @stocks = @user.stocks.order("category_id")
      flash.now[:alert] = "変更に失敗しました。"
      render :index
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    name = @stock.name
    @stock.destroy
    if@stock.destroy
      redirect_to user_path(current_user.id), notice: "#{name}を削除しました"
    else
      @stocks = @user.stocks.order("category_id")
      flash.now[:alert] = "変更に失敗しました。"
      render :index
    end
  end

  def order
    @order = Stock.new(stock_params)
    @stock = Stock.find_by(user_id: @order.user_id, name: @order.name)
    if @stock.present?
      @stock.num = "#{@stock.num} + #{@order.num}"
      if @stock.save
        redirect_to user_path(current_user.id), notice: "#{@stock.name}の個数を変更しました"
      else
        render_mypage
      end
    else
      if @order.save
        redirect_to user_path(current_user.id), notice: "#{@order.name}を在庫に追加しました"
      else
        render_mypage
      end
    end
  end

  private
  def stock_params
    params.require(:stock).permit(:num, :name, :category_id).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to user_path(@user.id) if current_user.id != @user.id
  end

  def render_mypage
    @user = User.find_by( id: @plan.user_id)
    @stocks = @user.stocks.order("category_id")
    @shoppings = @user.shoppings.order("category_id")
    @recipes = @user.recipes.includes(recipe_tags: []).where(release: 1).order("created_at DESC").page(params[:page]).per(10)
    @myrecipes = @user.recipes.includes(recipe_tags: []).order("created_at DESC").page(params[:page]).per(10)
    @plans = @user.plans.includes(:recipe).order("date")
    likes = Like.where(user_id: current_user.id).pluck(:recipe_id)
    @like_recipes = Recipe.where(id: likes).includes(recipe_tags: []).order("created_at DESC").page(params[:page]).per(10)
    flash.now[:alert] = "変更に失敗しました。"
    render "users/show"
  end
end
