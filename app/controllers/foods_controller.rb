class FoodsController < ApplicationController
  before_action :authenticate_user!
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to foods_path
    else
      render 'new'
    end
  end

  def index
    @foods = Food.order("name")
  end

  def search
    @foods = Food.search(params[:keyword]).order("name")
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.save
      redirect_to foods_path
    else
      render 'edit'
    end
  end
  private

  def food_params
    params.require(:food).permit(:name, :time, :unit_id, :food_tag_id)
  end
end
