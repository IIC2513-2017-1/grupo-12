# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    before_action :authenticate, only: %i[show follow unfollow followers following]
    def show
      @user = User.find(params[:id])
      @supported_projects = @user.donations.map(&:project).uniq
    end

    def followers
      @user = User.find(params[:id])
      render json: @user.followers.select([:firstname, :lastname,:id, :birthdate])
    end

    def following
      @user = User.find(params[:id])
      render json: @user.following.select([:firstname, :lastname,:id, :birthdate])
    end


    def follow
      @user = User.find(user_params[:id])
      if @current_user.following? @user
        render json: { status: 200, message: "You are already following user #{user_params[:id]}" }
      else
        follower_relationship = @current_user.follow(@user)
        unless @user.chat_id.nil?
          text = "#{@current_user.fullname} started following you!\n"
          text += "Check his/her profile here: #{user_url(@current_user)}"
          BOT.send_message(@user.chat_id, text)
          puts "SENDING NOTIF OF FOLLOW TO #{@user} #{@user.chat_id}"
        end
        render json: {
          following: {
            id: @user.id
          },
          follow: {
            id: follower_relationship.id,
            followers: @user.followers.count
          }
        }
      end
    end

    def unfollow
      @user = User.find(user_params[:id])
      if @current_user.following? @user
        other_user = User.find(user_params[:id])
        @current_user.unfollow(other_user)
        render json: {
          unfollowing: {
            id: @user.id,
            followers: @user.followers.count
          }
        }
      else
        render json: { status: 200, message: "You are not following user #{user_params[:id]}" }
      end
    end

    private

    def user_params
      # params[:birthdate].to_date
      params.permit(:firstname, :lastname, :email, :password,
                    :password_confirmation, :description, :birthdate, :id)
    end

  end
end
