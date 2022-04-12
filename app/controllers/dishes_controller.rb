class DishesController < ApplicationController
  def new
    @dish = Dish.new

  end

  def index
    @dishes = Dish.all
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def show
    @dish = Dish.find(params[:id])

  end

  def create
    @dish = Dish.new(dish_params)
    @dish.save
    redirect_to user_path(current_user.id)
  end

  def update
    dish = Dish.find(params[:id])
    dish.update(dish_params)
    redirect_to dish_path(dish.id)
  end

  def confirm

  end

  def destroy
        @dish = Dish.find(params[:id])
        if @dish.destroy
            redirect_to user_path(@dish.user_id)
        else
            render :edit
        end
  end

  private

  def dish_params
    params.require(:dish).permit(:dish_name, :introduction, :user_id, :dish_image).merge(user_id: current_user.id)

  end

end
