class FavoritesController < ApplicationController

  def create
    dish = Dish.find(params[:dish_id])
    favorite = current_user.favorits.new(dish_id: dish.id)
    favorite.save
    dish.create_notification_favorite!(current_user)
    redirect_to dish_path(dish.id)
  end

  def destroy
    dish = Dish.find(params[:dish_id])
    favorite = current_user.favorits.find_by(dish_id: dish.id)
    favorite.destroy
    redirect_to dish_path(dish.id)
  end
end
