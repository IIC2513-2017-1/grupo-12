class UserMailer < ApplicationMailer
  default from: 'dreamfunder.noreply@gmail.com'

  def account_activation(user)
    @user = user
    mail to: @user.email, subject: "Account activation"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def test_mail
    @user = User.first
    mail to: @user.email, subject: "TEST EMAIL"
  end

end
