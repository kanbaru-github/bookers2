class PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.book_id = @book.id
    # どの本に紐づいたものなのか知るため
    @post_comment.user_id = current_user.id
    unless @post_comment.save
      render 'eeror'
      # renderを用いた場合は指定した名前のjs.erbを読みに行きます。
    end
    # form_withでフォームを送信した時は、デフォルトでjsファイルを探しにいく設定になっています。
    # htmlファイルを探しにいってほしい場合は、form_withの後にlocal: trueと記載する必要があります。
    # form_でフォームを送信し、jsファイルを探しに行って欲しい場合はremote: trueと記載する必要があります。
  end

  def destroy
    @book = Book.find(params[:book_id])
    post_comment = @book.post_comments.find(params[:id])
    post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
