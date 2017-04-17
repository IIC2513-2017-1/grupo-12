class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit; end

  def update; end

  def destroy; end

  private

  # Allowed parameters for user creation
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password,
                                 :password_confirmation, :description)
  end
end
