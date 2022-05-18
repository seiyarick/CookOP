class DishesController < ApplicationController
  before_action :ensure_dish, only: [:edit, :update, :destroy]

  def new
    @dish = Dish.new
  end

  def ranking
    @all_ranks = Dish.create_all_ranks
  end

  def index
    # @dishes = Dish.all
    @q = Dish.ransack(params[:q])
    @searchs = @q.result(distinct: true).page(params[:page]).order("id DESC")
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def show
    @dish = Dish.find(params[:id])
    @comment = Comment.new
    @comments = @dish.comments
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      redirect_to user_path(current_user.id), flash: {notice: "投稿が完了しました"}
    else
      render :new
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update(dish_params)
      redirect_to dish_path(@dish.id)
    else
      render 'edit'
    end
  end

  def confirm

  end

  def search
    @q = Dish.ransack(params[:q])
    @dishes = @q.result(distinct: true)
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

  def ensure_dish
    @dishes = current_user.dishes
    @dish = @dishes.find_by(id: params[:id])
    flash[:notice]="権限がありません"
    redirect_to new_dish_path unless @dish
  end

end
