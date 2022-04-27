class CommentsController < ApplicationController
  def create
    dish = Dish.find(params[:dish_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.dish_id = dish.id
    if comment.save
      # dish.create_notification_comment!(current_user, comment.id)
      redirect_to dish_path(dish.id), flash: {comment: "コメントしました"}
    else
      redirect_to dish_path(dish.id)
    end
  end

  def destroy

    Comment.find(params[:id]).destroy
    redirect_to dish_path(params[:dish_id])

  end


  private

  def comment_params
    params.require(:comment).permit(:comment_text, :comment_count)
  end
end
