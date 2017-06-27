# frozen_string_literal: true

module Api::V1
  class CommentsController < ApiController
    before_action :authenticate

    def create
      @comment = @current_user.comments.build(comment_params)
      return if @comment.save
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end

    private

    def comment_params
      params.require(:comment).permit(:project_id, :content)
    end
  end
end
