# frozen_string_literal: true

module Api::V1
  class TelegramController < ApiController
    before_action :authenticate
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
