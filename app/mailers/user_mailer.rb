class UserMailer < ApplicationMailer
  default from: 'dreamfunder.noreply@gmail.com'

  def account_activation(user)
    @user = user
    mail to: @user.email, subject: 'Account activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password reset'
  end

  def test_mail
    @user = User.first
    mail to: @user.email, subject: 'TEST EMAIL'
  end
end
