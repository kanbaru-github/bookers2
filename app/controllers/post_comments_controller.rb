class PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.book_id = @book.id
    @post_comment.user_id = current_user.id
    unless @post_comment.save
      render 'eeror'
    end
    # @post_comment = @book.post_comments.build(post_comment_params)
    # 投稿に紐づいたコメントを作成
    # buildを使うことで、@bookのidをbook_idに含んだ形でpost_commentインスタンスを作成
    # @post_comment.user_id = current_user.id
    # @post_comment.save
    # render :index
    # 保存がされると、render :indexによって「app/views/comments/index.js.erb」を探す。
    # form_withでフォームを送信した時は、デフォルトでjsファイルを探しにいく設定になっています。
    # htmlファイルを探しにいってほしい場合は、form_withの後にlocal: trueと記載する必要があります。
    # form_でフォームを送信し、jsファイルを探しに行って欲しい場合はremote: trueと記載する必要があります。

    # comment = current_user.post_comments.new(post_comment_params)
    # comment = PostComment.new(post_comment_params) &&
    # comment.user_id = current_user.id と同じ
    # comment.book_id = book.id
    # どの本に紐づいたものなのか知るため
    # comment.save
    # redirect_to book_path(book)

  end

  def destroy
    @book = Book.find(params[:book_id])
    post_comment = @book.post_comments.find(params[:id])
    post_comment.destroy

    # PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_to book_path(params[:book_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
