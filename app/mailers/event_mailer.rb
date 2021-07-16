class EventMailer < ApplicationMailer

  def send_mail(group_users, title, content)
    # 今回は返信がグループのユーザー達のe-mailに届くようにします。なのでメソッドをsend_mailと定義しました。
    @title = title
    # タイトル情報
    # mailメソッドが呼び出されると、メール本文が記載されているビューが読み込まれます。
    # インスタンス変数(@xxx)でメーラービューに値を渡してあげたいので、インスタンス変数を用意してる感じ
    @content = content
    # 内容情報
    mail bcc: group_users.pluck(:emai), subject: title
    # ブラインドカーボンコピー　pluckメソッドとは、引数に指定したカラムの値を配列で返してくれるメソッドです
  end

end
