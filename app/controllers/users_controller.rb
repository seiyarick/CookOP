class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @profile_image = @user.image
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
    params.require(:user).permit(:name, :image, :profile)
  end  
end
