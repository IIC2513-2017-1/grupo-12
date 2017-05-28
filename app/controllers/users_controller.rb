class UsersController < ApplicationController
  include Secured  
  before_action :logged_in?, only: %i[edit update destroy following followers owned funded saved]
  before_action :set_user, only: %i[show edit update destroy following followers owned funded saved]
  before_action :is_current_user?, only: %i[edit update destroy saved funded]

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

  def show; end

  def owned
    @title = 'Owned'
    @projects = @user.projects
  end

  def funded
    @title = 'Funded'
    @projects = @user.donations.map(&:project).uniq
  end

  def saved
    @title = 'Saved'
    @projects = @user.saving.uniq
    # render 'show_save'
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy; end

  def following
    @title = 'Following'
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers
    render 'show_follow'
  end

  private

  # Allowed parameters for user creation
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password,
                                 :password_confirmation, :description, :avatar)
  end

  def set_user
    @user = User.includes(followers: :passive_relationships, following: :active_relationships).find(params[:id])
  end

  def is_current_user?
    redirect_to(root_path, notice: 'Unauthorized access!') unless @user == current_user
  end

end
