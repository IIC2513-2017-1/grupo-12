# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    before_action :authenticate, only: [:update]

    def show
      @user = User.find(params[:id])
      @supported_projects = @user.donations.map(&:project).uniq
    end

    def create
      @user = User.new(user_params)
      @user.generate_token_and_save
      if @user.save
        @user.send_activation_email
        @user.generate_token_and_save
        return
      else
        render json: { errors: @project.errors }, status: :unprocessable_entity
      end
    end

    def update
      puts user_params
      @user = @current_user.update(user_params)
      return if @user.save
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end

    private

    def user_params
      #params[:birthdate].to_date
      params.require(:user).permit(:firstname, :lastname, :email, :password,
                                   :password_confirmation, :description, :birthdate,)
    end
  end
end
