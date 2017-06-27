# frozen_string_literal: true

class TelegramController < ApplicationController
  def handle
    puts params
    puts params[:chat_id]
  end
end
