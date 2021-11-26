require 'test_helper'

class MailerMailerTest < ActionMailer::TestCase
  test "send_when_order" do
    mail = MailerMailer.send_when_order
    assert_equal "Send when order", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
