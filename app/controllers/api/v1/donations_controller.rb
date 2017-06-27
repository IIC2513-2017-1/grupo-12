# frozen_string_literal: true

module Api::V1
  class DonationsController < ApiController
    before_action :authenticate

    def create
      @donation = @current_user.donations.build(donation_params)
      return if @donation.save
      render json: { errors: @donation.errors }, status: :unprocessable_entity
    end

    private

    def donation_params
      params.require(:donation).permit(:project_id, :amount)
    end
  end
end
