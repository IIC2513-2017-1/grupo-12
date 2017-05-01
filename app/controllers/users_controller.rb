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

  def owned
    @title = 'Owned'
    @user = current_user
    @projects = @user.projects
  end

  def funded
    @title = 'Funded'
    @user = current_user
    @projects = @user.donations
  end

  def saved
    @title = 'Saved'
    @user = current_user
    @projects = @user.saving
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
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  # Allowed parameters for user creation
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password,
                                 :password_confirmation, :description)
  end
end
