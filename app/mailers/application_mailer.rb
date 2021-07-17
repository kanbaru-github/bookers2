class ApplicationMailer < ActionMailer::Base
  # application_mailerは全メーラー共通の設定

  default from: '管理人 <from@example.com>'
  # 共通の処理・設定を記述する場合にはdefaultメソッドを使用
  # from:メールの送信元名
  layout 'mailer'
  # mailer.(html|text).erbをレイアウトとして使用

end
