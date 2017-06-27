# frozen_string_literal: true

module Api::V1
  class TelegramController < ApiController
    skip_before_action :verify_authenticity_token
    def handle
      puts params
      puts "HERE COMES THE ID"
      puts params[:message][:chat][:id]
      if @current_user.nil?
        puts "NOT AUTHORIZED"
      end
    end
  end
end
