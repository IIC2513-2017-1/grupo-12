# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    before_action :authenticate, only: %i[create save forget]

    def index
      @projects = Project.all
    end

    def create
      # @project = Project.new(project_params)
      @project = @current_user.projects.build(project_params)
      if @project.save
        cats = params[:category_ids]&.map! { |c| c.to_i }
        unless cats.nil?
          cats.delete(0)
          categories = Category.where(id: cats)
          categories.each do |cat|
            @project.add_category(cat)
          end
        end
        render json: { status: 200, link: project_url(@project) }
      else
        render json: { errors: @project.errors }, status: :unprocessable_entity
      end
    end

    def show
      @project = Project.find(params[:id])
    end

    def save
      @project = Project.find(params[:id])
      relation = @current_user.save_project(@project)
      @followers = @project.savers.count
      return if relation
      render json: { errors: relation.errors }, status: :unprocessable_entity
    end

    def forget
      @project = Project.find(params[:id])
      forgotten = @current_user.forget_project(@project)
      @followers = @project.savers.count
      return if forgotten
      render json: { errors: forgotten.errors }, status: :unprocessable_entity
    end

    private

    def project_params
      params.require(:project).permit(:brief, :description, :funding_duration, :funding_goal, images: [], category_ids: [])
    end
  end
end
