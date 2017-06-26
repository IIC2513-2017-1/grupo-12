# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'dreamfunder.noreply@gmail.com'

  def goal_reached(project, user)
    @project = project
    @user = user
    mail to: @user.email, subject: 'Project Goal Reached'
  end
end
