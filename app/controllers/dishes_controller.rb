class DishesController < ApplicationController
  def new
    @dish = Dish.new

  end

  def index
  end

  def edit
    @dish = Dish.find
  end

  def show
    @dish = Dish.find(params[:id])
    
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.save
    redirect_to user_path(current_user.id)
  end

  private

  def dish_params
    params.require(:dish).permit(:dish_name, :introduction, :user_id, :dish_image).merge(user_id: current_user.id)

  end

end
