class ApplicationMailer < ActionMailer::Base

  default from: '管理人 <from@example.com>'
  # from	メールの送信元名
  layout 'mailer'

end
