class BooksController < ApplicationController

  before_action :authenticate_user!
  # これを記述することで認証ユーザーのみ各アクションを実行するようになります。
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  # 正しいユーザーかを確かめるという意味

  def index
    # 一週間分のレコードを取得
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
    # booksモデルからデータを取得するときに、favorited_usersモデルのデータもまとめて取得
      sort {|a,b|
      # デフォルトは昇順 ↔︎ .rever
      # ブロックに2つの要素を引数として与えて評価し、その結果で比較
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      # ViewCountモデルの中にcurrent_user.idのuser_idと＠book.idのbook_idが見つからなかったら
      current_user.view_counts.create(book_id: @book.id)
    end
    @post_comment = PostComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 誰が投稿を行ったかを知るため
    if @book.save
      redirect_to book_path(@book), notice: 'Created book successfully.'
    else
      @books = Book.all
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
    params.require(:book).permit(:title, :body)
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
