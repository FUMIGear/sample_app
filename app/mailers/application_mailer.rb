# リスト 11.9:Applicationメーラー
# リスト 11.11:fromアドレスのデフォルト値を更新したアプリケーションメーラー
class ApplicationMailer < ActionMailer::Base
  # default from: "from@example.com"
  default from: "user@realdomain.com" # 運用する場合は自分のメルアドを入れる
  layout "mailer"
end
