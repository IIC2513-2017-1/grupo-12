# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'dreamfunder.noreply@gmail.com'

  def goal_reached(project, user)
    @project = project
    @user = user
    mail to: @user.email, subject: 'Dreamfunder - Project Goal Reached'
  end

  def activate_service(user, chat_id)
    @user = user
    @chat_id = chat_id
    mail to: @user.email, subject: 'Dreamfunder - Telegram Notification Service'
  end
end
