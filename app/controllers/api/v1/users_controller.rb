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
      if @user.save
        @user.send_activation_email
        return
      else
        render json: { errors: @project.errors }, status: :unprocessable_entity
      end
    end

    def update
      respond_to do |format|
        puts user_params
        @user = @current_user.update(user_params)
        return if @user.save
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      pramas[:birthdate].to_date
      params.require(:user).permit(:firstname, :lastname, :email, :password,
                                   :password_confirmation, :description, :birthdate,)
    end
  end
end
