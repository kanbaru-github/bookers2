class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    # favorite = current_user.favorites.new(book_id: @book.id)
    #book_idはfavorite テーブルにあるカラム名,book.idは４行目のbookのid
    favorite.save
    # redirect_back(fallback_location: root_path)
    # redirect_toを指定してしまうと画面遷移が行われてしまい、非同期通信が行われない。
    # 遷移先を元のページに設定。root_pathはtopページではなく、最後のページという意味
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    # favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

end
