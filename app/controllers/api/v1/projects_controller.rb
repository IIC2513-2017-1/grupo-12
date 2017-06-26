# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    before_action :authenticate

    def index
      @projects = Project.all
    end

    def create
      # @project = Project.new(project_params)
      puts project_params
      @project = @current_user.projects.build(project_params)
      if @project.save
        render json: { status: 200, link: project_url(@project) }
      else
        render json: { errors: @project.errors }, status: :unprocessable_entity
      end
    end

    private

    def project_params
      params.require(:project).permit(:category_ids, :brief, :description, :funding_duration, :funding_goal, images: [])
    end
  end
end
