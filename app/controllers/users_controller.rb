class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
    @dishes = @user.dishes.all.order("id DESC").page(params[:page])
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'users/edit'
    end
  end

  def update_delete
    user=current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
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
