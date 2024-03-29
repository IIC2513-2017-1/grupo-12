# frozen_string_literal: true

##
# Module for securing controllers access
module Secured
  extend ActiveSupport::Concern

  ##
  # Verify if current_user is logged_in
  def is_logged_in?
    redirect_to(root_path, notice: 'Unauthorized access!') unless current_user
  end
end
