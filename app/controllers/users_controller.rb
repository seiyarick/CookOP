class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
    @dishes = @user.dishes.all.order("id DESC")
    @user_dishes = @user.dishes
    @favorits_count = 0

    @user_dishes.each do |dish|
      @favorits_count += dish.favorits.count
    end

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


  def index
    @users = User.where.not(id: current_user.id).page(params[:page])
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end
end
