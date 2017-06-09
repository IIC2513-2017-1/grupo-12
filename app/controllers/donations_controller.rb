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
    respond_to do |format|
      if @donation.save
        format.html { redirect_to project_path(@donation.project), notice: 'Donation was successfully created.' }
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
