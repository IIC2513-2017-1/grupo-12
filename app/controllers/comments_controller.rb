# frozen_string_literal: true

class CommentsController < ApplicationController
  include Secured
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :is_logged_in?, only: %i[new create edit update destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @project = @comment.project
    respond_to do |format|
      if @comment.save
        text = "The project '#{@project.brief}' has a new comment on it: \n"
        text += "#{@comment.user.fullname}: '#{@comment.content.strip()}'\n"
        text += "Visit it here to know more: #{project_url(@project)}"
        registry = []
        if !@project.user.chat_id.nil?
          BOT.send_message(@project.user.chat_id, text)
        end
        User.donors_of(@project).with_telegram.each do |user|
          BOT.send_message(user.chat_id, text)
          registry << user.id
        end
        @project.savers.with_telegram.each do |user|
          BOT.send_message(user.chat_id, text) unless registry.include?(user.id)
        end
        format.html { redirect_to project_path(@comment.project, anchor: 'comments-section'), notice: 'Comment was successfully created.' }
        format.js { render 'new_comment.js.erb' }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :project_id).merge(user_id: current_user.id)
  end
end
