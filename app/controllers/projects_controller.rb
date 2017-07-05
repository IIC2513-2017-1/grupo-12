# frozen_string_literal: true

class ProjectsController < ApplicationController
  include Secured
  before_action :set_project, only: %i[show edit update destroy save forget claim]
  before_action :project_params, only: %i[create update]
  before_action :is_logged_in?, only: %i[new create edit update destroy]

  # GET /projects
  # GET /projects.json
  def index
    extra = ''
    @category = ''
    @projects = Project.paginate(page: params[:page])
    if params['category'] && params['category'].to_i.positive?
      cat = Category.find(params['category'])
      @category = cat.name
      @projects = Project.with_category(cat).paginate(page: params[:page])
      extra = " about #{@category}".upcase
    end
    @title = "EXPLORE #{@projects.count} " + 'project'.pluralize(@projects.count).upcase + extra
    @default = if cat.nil?
                 0
               else
                 cat.id
               end
    respond_to do |format|
      format.js do
        render 'index.js.erb'
      end
      format.html { render :index }
    end
    # @projects = Project.paginate(page: params[:page])
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if logged_in?
      @default = if current_user.saving?(@project)
                   'Unfollow'
                 else
                   'Follow'
                 end
    end
    @comments = @project.comments
    @donated = @project.donations.map(&:amount).inject(0) { |sum, x| sum + x }
    @supporters = @project.donations.pluck(:user_id).uniq.count
    @followers = @project.savers.count
    @comment = Comment.new
  end

  # GET /projects/new
  def new
    @project = Project.new
    @min_date = Date.today + 20.days
    @categories = []
  end

  # GET /projects/1/edit
  def edit
    @min_date = Date.today + 20.days
    @categories = @project.categories
  end

  # POST /projects
  # POST /projects.json
  def create
    # @category_id = project_params[:category_ids]
    project_params.delete :category_ids
    # @category = Category.find(project_params[:category_ids])
    @project = Project.new(project_params.except(:images))
    # @project.add_category(@category)
    cat_ids = project_params[:category_ids]&.map(&:to_i)
    if cat_ids.nil?
      redirect_to new_project_path, notice: 'Choose at least one category!'
    else
      puts cat_ids
      categories = Category.where(id: cat_ids)
      categories.each do |cat|
        @project.add_category(cat)
      end
      respond_to do |format|
        if @project.save
          params[:images]&.each do |image|
            Picture.create(image: image, project: @project)
          end
          format.html { redirect_to @project, notice: 'Project was successfully created.' }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    cat_ids = project_params[:category_ids]&.map(&:to_i)
    if cat_ids.nil?
      redirect_to edit_project_path(@project), notice: 'Choose at least one category!'
    else
      puts cat_ids
      categories = Category.where(id: cat_ids)
      categories.each do |cat|
        @project.add_category(cat)
      end
      respond_to do |format|
        if @project.update(project_params)
          params[:images]&.each do |image|
            Picture.create(image: image, project: @project)
          end
          format.html { redirect_to @project, notice: 'Project was successfully updated.' }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
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
    relation = current_user.save_project(@project)
    followers = @project.savers.count
    if relation
      unless @project.user.chat_id.nil?
        text = "#{current_user.fullname} bookmarked your project '#{@project.brief}'!\n"
        text += "Check his/her profile here: #{user_url(current_user)}"
        BOT.send_message(@project.user.chat_id, text)
      end
      # @user = current_user
      # @comments = @project.comments
      # @donated = @project.donations.map(&:amount).inject(0) { |sum, x| sum + x }
      # @user.save_project(@project)
      # redirect_to @project
      respond_to do |format|
        format.json do
          render json: {
            saved: {
              id: @project.id
            },
            saver: {
              id: relation.id
            },
            followers: {
              num: "#{followers} users".pluralize(followers)
            }
          }
        end
      end
    end
  end

  def search
    Project.reindex
    @projects = Project.search params[:search]
    @title = "#{@projects.count} " + 'result'.pluralize(@projects.count).upcase + " FOUND  FOR '#{params[:search].upcase}'"
    render 'index'
  end

  def forget
    @user = current_user
    @user.forget_project(@project)
    followers = @project.savers.count
    # redirect_to @project
    respond_to do |format|
      format.json do
        render json: {
          unfollowing: {
            id: @project.id
          },
          followers: {
            num: "#{followers} users".pluralize(followers)
          }
        }
      end
    end
  end

  def categories
    @title = 'Categories'
    @project = Project.find(params[:id])
    @categories = @project.categories
    # render 'show_follow'
  end

  def claim
    if @project.user_id == current_user.id && @project.funding_duration <= Date.today
      @project.finished = true
      @project.save
      current_user.increase_wallet(@project.donated)
    end
    redirect_to @project
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:brief, :description, :funding_duration, :funding_goal, images: [], category_ids: []).merge(user_id: current_user.id)
  end
end
