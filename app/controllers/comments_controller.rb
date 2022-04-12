class CommentsController < ApplicationController
  def create
    dish = Dish.find(params[:dish_id])
    comment = Comment.new(comment_params)

    comment.user_id = current_user.id
    comment.dish_id = dish.id

    comment.save
    redirect_to dish_path(dish.id)
  end


  private

  def comment_params
    params.require(:comment).permit(:comment_text, :comment_count)
  end
end
