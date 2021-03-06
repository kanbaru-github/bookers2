class RelationshipsController < ApplicationController

  before_action :authenticate_user!
  # 認証ユーザーのみにアクセスを許可する

  def create
  	current_user.follow(params[:user_id])
  	# userテーブルからidを受け取るため
  	redirect_to request.referer
  	# 遷移前のページのURL取得
  end

  def destroy
  	current_user.unfollow(params[:user_id])
		# userモデルで定義したものを受け取る
		redirect_to request.referer
  end

  def followings
  	user = User.find(params[:user_id])
		@users = user.followings
  end

  def followers
  	user = User.find(params[:user_id])
		@users = user.followers
  end

end
