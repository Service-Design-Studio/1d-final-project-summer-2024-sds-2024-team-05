class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]
  before_action :set_all_meetings

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to patients_dashboard_path, notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy!

    respond_to do |format|
      format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def set_all_meetings
      @meetings = Meeting.where(
        start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
      )
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      permitted_params = params.require(:meeting).permit(:title, :description, :location, :start_time, :end_time, :form_id)
      puts permitted_params
      @form = Form.find(permitted_params[:form_id])
      permitted_params[:title] = " #{@form.first_name} #{@form.last_name}"
      permitted_params
    end
end
