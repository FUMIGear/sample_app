# リスト 11.10:生成されたUserメーラー
class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject

  # デフォのメソッドは使わないと思う。
  # def account_activation
  #   @greeting = "Hi"
  #   mail to: "to@example.org"
  # end
  # リスト 11.12:アカウント有効化リンクをメール送信する red
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
