class DonationsController < ApplicationController
  include Secured
  before_action :set_donation, only: %i[show edit update destroy]
  before_action :is_logged_in?, only: %i[new create edit update destroy]

  # GET /donations/new
  def new
    @donation = Donation.new
    @project = Project.find(params[:project_id])
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

  # Use callbacks to share common setup or constraints between actions.
  def set_donation
    @donation = Donation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def donation_params
    params.require(:donation).permit(:project_id, :amount).merge(user: current_user)
  end
end
