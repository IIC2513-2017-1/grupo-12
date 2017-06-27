# frozen_string_literal: true

module Api::V1
  class TelegramController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    skip_before_action :verify_authenticity_token
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    def activate
      if params[:token] && params[:chat_id]
        token = params[:token]
        chat_id = params[:chat_id]
        current_user = User.find_by(token: token)
        current_user.update_attribute(:chat_id, chat_id.to_i)
        BOT.send_message(chat_id, 'Notifications are now enabled!')
        render json: { status: 200, link: root_url }
      end
    end

    def handle
      # token = request.headers["Authorization"]
      # if token.nil?
      #   puts "NO TOKEN"
      # else
      #   token.slice! "Bearer "
      # end
      # puts token
      if params.key? :message
        begin
          chat_id = params[:message][:chat][:id]
          message = params[:message][:text]
        rescue
          puts 'Failed'
        end
      end
      unless message.nil?
        if message == '/start'
          text = "Welcome to dreamfunder.herokuapp.com!\n\n"
          text += "If you want to receive notifications from your projects, use the command /activate followed by the email you registered in Dreamfunder.\n"
          text += 'Example: /activate myemail@gmail.com'
          BOT.send_message(chat_id, text)
        elsif message.start_with? '/activate'
          email = message.sub! '/activate', ''
          email.strip!
          if !!(email =~ VALID_EMAIL_REGEX)
            user = User.find_by(email: email)
            if user
              if user.chat_id.nil?
                BOT.send_message(chat_id, 'Check your email to activate this service.')
                NotificationMailer.activate_service(user, chat_id).deliver_now
              else
                BOT.send_message(chat_id, 'This service is already enabled')
              end
            end
          else
            BOT.send_message(chat_id, 'The email provided is not valid. Try again.')
          end
        end
      end
    end
  end
end
