class Mailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer_mailer.send_when_post.subject
  #
  def send_when_post(user)
    @user = user
    mail to: user.email,
         subject: 'お手紙が届きました。'
  end
end
