class FoodsController < ApplicationController
  before_action :authenticate_user!
  def new
    @food = Food.new
  end
  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to root_path 
    else
      render "new" 
    end
  end
  private

  def food_params
    params.require(:food).permit(:name, :time, :unit_id, :food_tag_id)
  end
end
