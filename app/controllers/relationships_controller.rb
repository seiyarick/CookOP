class RelationshipsController < ApplicationController
  before_action :authenticate_user!#ログインしていないユーザーには遷移してほしくないため


  def index_follow
  end

  def index_follower
  end

  def create
    # @user = User.find(params[:following_id])
    @following = current_user.relationships.build(follower_id: params[:user_id])#current_userにはfollow_id,follower_idにはuser_idが
    @following.save
    @following.create_notification_follow!(current_user)
    redirect_to request.referrer || root_path#request.referrerでもとの画面に戻ってくる。なければルートパス

  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path

  end


  private


end
