class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def follower
    @user = User.find(params[:user_id])
    # params[:id]はURLからidを取ってくる。:user_idはrails routesより
    @users = @user.follower_user

  end

  def followed
    @user = User.find(params[:user_id])
    # params[:id]はURLからidを取ってくる。:user_idはrails routesより
    @users = @user.followed_user
  end

end
