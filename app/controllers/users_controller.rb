class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
    @dishes = @user.dishes.all

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
   
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def confirm
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
