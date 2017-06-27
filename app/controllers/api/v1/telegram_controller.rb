# frozen_string_literal: true

module Api::V1
  class TelegramController < ApiController
    protect_from_forgery unless: -> { request.format.json? }
    # before_action :authenticate
    def handle
      puts params
      puts "HERE COMES THE ID"
      puts params[:message][:chat][:id]
    end
  end
end
