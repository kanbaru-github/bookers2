class FavoritesController < ApplicationController

def create
  book = Book.find(params[:book_id])
  favorite = current_user.favorites.new(book_id: book.id)
  #book_idはfavorite テーブルにあるカラム名,book.idは４行目のbookのid
  favorite.save
  redirect_back(fallback_location: root_path)
  # 遷移先を元のページに設定。root_pathはtopページではなく、最後のページという意味
end

def destroy
  book = Book.find(params[:book_id])
  favorite = current_user.favorites.find_by(book_id: book.id)
  favorite.destroy
  redirect_back(fallback_location: root_path)
end

end
