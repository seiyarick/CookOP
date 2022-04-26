class RelationshipsController < ApplicationController
  before_action :authenticate_user!#ログインしていないユーザーには遷移してほしくないため


  def index_follow
  end

  def index_follower
  end

  def create
    current_user.follow(params[:user_id])


    @user = User.find(params[:user_id])
    #following = current_user.relationships.build(follower_id: params[:user_id])#current_userにはfollow_id,follower_idにはuser_idが

    # following.save
    @user.create_notification_follow!(current_user)#通知の作成

    redirect_to request.referrer || root_path#request.referrerでもとの画面に戻ってくる。なければルートパス

  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path

  end


  private


end
