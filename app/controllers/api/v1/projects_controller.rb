module Api::V1
  class ProjectsController < ApiController
    before_action: :authenticate

    def index
      @projects = Project.all
    end

    def create
      #@project = Project.new(project_params)
      @project = @current_user.projects.build(project_params)
      return if @project.save
      render json: { errors: @project.errors }, status: :unprocessable_entity
    end

    private

    def project_params
      params.require(:project).permit(:category_ids, :brief, :description, :funding_duration, :funding_goal, images: [])
    end
  end
end
