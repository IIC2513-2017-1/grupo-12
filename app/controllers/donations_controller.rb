# frozen_string_literal: true

class DonationsController < ApplicationController
  include Secured
  before_action :is_logged_in?, only: %i[new create]

  # GET /donations/new
  def new
    @project = Project.find(params[:project_id])
    if Date.today <= @project.funding_duration
      @donation = Donation.new
    else
      redirect_to @project
    end
  end

  # GET /donations/1/edit

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(donation_params)
    @project = @donation.project
    respond_to do |format|
      if @donation.save
        if @project.remaining.negative? && !@project.achieved
          @project.update achieved: true
          text = "The project #{@project.brief} has reached its goal!\n"
          text += "It currently has raised about #{view_context.number_to_currency(@project.donated, :precision => 0)}\n"
          text += "Visit it here to know more: #{project_url(@project)}"
          if !@project.user.chat_id.nil?
            BOT.send_message(@project.user.chat_id, text)
          end
          User.donors_of(@project).each do |user|
            NotificationMailer.goal_reached(@project, user).deliver_now
            next if user.chat_id.nil?
            BOT.send_message(user.chat_id, text)
          end
          @project.savers.with_telegram.each do |user|
            BOT.send_message(user.chat_id, text)
          end
        end
        format.html { redirect_to project_path(@project), notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json

  # DELETE /donations/1
  # DELETE /donations/1.json

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def donation_params
    params.require(:donation).permit(:project_id, :amount).merge(user: current_user)
  end
end
