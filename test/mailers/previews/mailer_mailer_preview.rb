# Preview all emails at http://localhost:3000/rails/mailers/mailer_mailer
class MailerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mailer_mailer/send_when_order
  def send_when_order
    MailerMailer.send_when_order
  end

end
