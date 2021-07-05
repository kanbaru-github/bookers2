class SearchController < ApplicationController

before_action :authenticate_user!
# ログイン済ユーザーのみにアクセスを許可する

  def search
    @model = params[:model]
    @keyword = params[:keyword]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@keyword, @method)
    else
      @records = Book.search_for(@keyword, @mathod)
    end
  end
end
