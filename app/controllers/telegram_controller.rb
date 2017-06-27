# frozen_string_literal: true

class TelegramController < ApplicationController
  before_action :authenticate
  def handle
    puts params
    puts params[:chat_id]
  end
end
