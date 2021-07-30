class UsersController < ApplicationController

  before_action :authenticate_user!
  # ログイン認証されていなければ、ログイン画面へリダイレクトする
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    # @user = current_user
    @book = Book.new
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books
    # モデル名.where(カラム名: 条件) (例)@books = Book.where(user_id: @user.id)でも可能
    @book = Book.new
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end

  def edit
  end
  # ストロングパラメーターで定義済み

  def update
    if @user.update(user_params)
      # ストロングパラメーターから受け取る
      redirect_to user_path(@user), notice: 'Updated user successfully.'
    else
      render :edit
    end
  end

  def follower
  end

  def followed
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
