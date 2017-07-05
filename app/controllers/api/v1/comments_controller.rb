# frozen_string_literal: true

module Api::V1
  class CommentsController < ApiController
    before_action :authenticate

    def create
      @comment = @current_user.comments.build(comment_params)
      return if @comment.save
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end

    def index
      @comments = Project.find(comment_params[:project_id].to_i).comments
      render json: @comments
    end

    def show
      @comment = Comment.find(comment_params[:id].to_i)
      render json: @comment
    end

    private

    def comment_params
      params.permit(:project_id, :content, :id)
    end
  end
end
