class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book_new = Book.new
    @books = Book.all
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 誰が投稿を行ったかを知るため
    if @book.save
      redirect_to book_path(@book), notice: 'successfully!'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'successfully!'
    else
      render :edit
    end
  end

  def destroy
     book = Book.find(params[:id])
     book.destroy
     redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
