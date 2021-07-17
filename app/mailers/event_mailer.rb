class EventMailer < ApplicationMailer
  # event_mailerはメーラー個別の設定

  def send_mail(group_users, title, content) #メソッドに対して引数を設定
    # 今回は返信がグループのユーザー達のe-mailに届くようにするのでメソッドをsend_mailと定義
    @title = title
    # タイトル情報
    # mailメソッドが呼び出されると、メール本文が記載されているビューが読み込まれます。
    # インスタンス変数(@xxx)でメーラービューに値を渡してあげたいので、インスタンス変数を用意してる感じ
    @content = content
    # 内容情報
    mail bcc: group_users.pluck(:email), subject: title
    # to:TO（宛先）に指定してメールを送ることは「あなたに送っていますよ」という意思表示です。
    # cc:カーボン・コピー（Carbon Copy）の略。複写の意味。TO（宛先）がメインの送信先、CCが複写を送りたい相手。「CC」に入力したメールアドレスにも、同じメールが送信されます。「念のためにお送りします」という場合に「CC」を使います。
    # bcc:ブラインド・カーボン・コピーの略。入力されたメ－ルアドレスは、TOやCCや他のBCCでの受信者には表示されません。TO、CC、BCCの受信者に、他の受信者がいることを隠したい場合や、受信者のメ－ルアドレスが分からないようにして送りたい場合はBCCを使用。
    # pluckメソッドとは、引数に指定したカラムの値を配列で返してくれるメソッドです
  end

end
