class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]
  before_action :set_all_meetings

  # GET /meetings or /meetings.json
  def index
    if current_user.admin?
      @meetings = Meeting.all
    else
      @meetings = current_user.forms.includes(:meeting).map(&:meeting).compact
    end
    @meeting = Meeting.new()
    respond_to do |format|
      format.html
      format.json { render json: @meetings.to_json(include: { form: { only: [:id, :first_name, :last_name, :address] }})}
    end
  end

  # GET /meetings/1 or /meetings/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @meeting.to_json(include: :form)}
    end
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
        if @meeting.form_id.present?
          start_time = @meeting.start_time
          @form = Form.find(meeting_params[:form_id])
          begin
            MeetingMailer.schedule_meeting_email(@form, start_time).deliver_now
            flash[:message] = "Meeting scheduled and email sent successfully."
          rescue => e
            flash[:danger] = "There was an error sending the email: #{e.message}"
          end
          format.html { redirect_to client_profile_form_path(@form, status: 'Meeting Date Pending'), notice: "Meeting was successfully created." }
          format.json { render :show, status: :created, location: @meeting }
        elsif current_user.admin?
          format.html { redirect_to admin_root_path(start_date: DateTime.now), notice: "Meeting was successfully destroyed." }
          format.json { render :show, status: :created, location: @meeting }
        else
          format.html { redirect_to user_root_path, notice: "How did you do this." }
          format.json { head :no_content }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      old_start_time = @meeting.start_time
      if @meeting.update(meeting_params)
        if @meeting.form_id.present? &&@meeting.start_time != old_start_time
          new_start_time = @meeting.start_time
          @form = Form.find(@meeting.form_id)
          begin
            MeetingMailer.reschedule_meeting_email(@form, old_start_time, new_start_time).deliver_now
            flash[:message] = "Meeting rescheduled and Meeting Rescheduled email sent successfully."
          rescue => e
            flash[:danger] = "There was an error sending the email: #{e.message}"
          end
          
        end
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
    if @meeting.form
      @form = @meeting.form
      begin
        MeetingMailer.cancel_meeting_email(@form).deliver_now
        flash[:message] = "Meeting deleted and Meeting Cancellation email sent successfully."
      rescue => e
        flash[:danger] = "There was an error sending the email: #{e.message}"
      end
    end
    @meeting.destroy!

    respond_to do |format|
      if params[:origin] && @form
        format.html { redirect_to client_profile_form_path(@form), notice: "Meeting was successfully destroyed." }
        format.json { render json: {
            status: "Meeting was successfully destroyed."
          }
        }
      else
        if current_user.admin?
          format.html { redirect_to admin_root_path(start_date: DateTime.now), notice: "Meeting was successfully destroyed." }
          format.json { render json: {
            status: "Meeting was successfully destroyed."
          }
        }
        else
          format.html { redirect_to user_root_path, notice: "How did you do this." }
          format.json { head :no_content }
        end
      end
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
      permitted_params = params.require(:meeting).permit(:title, :description, :location, :start_time, :form_id)
      permitted_params[:start_time] = permitted_params[:start_time].in_time_zone('Asia/Singapore')
      permitted_params
    end
end
