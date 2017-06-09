class RelationshipsController < ApplicationController
  include Secured
  before_action :is_logged_in?, only: %i[new create edit update destroy]

  def create
    @user = User.find(params[:id])
    follower_relationship = current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json do
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
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json do
        render json: {
          unfollowing: {
            id: @user.id,
            followers: @user.followers.count
          }
        }
      end
    end
  end
end
