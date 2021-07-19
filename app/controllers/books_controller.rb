class BooksController < ApplicationController

  before_action :authenticate_user!
  # これを記述することで認証ユーザーのみ各アクションを実行するようになります。
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  # 正しいユーザーかを確かめるという意味

  def index
    @books = Book.all
    @book = Book.new
    # @user = current_user
  end

  def show
    # @book_new = Book.new
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
    # @post_comments = @book.post_comments.order(created_at: :desc)
    #新着順で表示
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 誰が投稿を行ったかを知るため
    if @book.save
      redirect_to book_path(@book), notice: 'Created book successfully.'
    else
      @books = Book.all
      # @user = current_user
      render :index
    end
  end

  def edit
  end
  # ストロングパラメーターで定義済み

  def update
    if @book.update(book_params)
      # ストロングパラメーターから送られてきた値を使う
      redirect_to book_path(@book), notice: 'Updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
     @book.destroy
     redirect_to books_path
  end

  private
  # このストロングパラメーターはここのclassでしか参照されない

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    # ここで定義しているのでedit,update,destroyには定義は不要
    unless @book.user == current_user
      # if !=と同じ
      redirect_to books_path
    end
  end
  # edit,update,destroyでのensure_current_userを定義している

end
