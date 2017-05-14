class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy, save]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @comments = @project.comments
    @donated = @project.donations.map(&:amount).inject(0) { |sum, x| sum + x }
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def savers
    @title = 'Savers'
    @project = Project.find(params[:id])
    @users = @project.savers
    # render 'show_save'
  end

  def save
    @user = current_user
    @comments = @project.comments
    @donated = @project.donations.map(&:amount).inject(0) { |sum, x| sum + x }
    @user.save_project(@project)
    redirect_to :action => "show"
  end


  def categories
    @title = 'Categories'
    @project = Project.find(params[:id])
    @categories = @project.categories
    # render 'show_follow'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:brief, :description, :funding_duration, :funding_goal).merge(user_id: current_user.id)
  end
end
