class AdminsController < ApplicationController
  include AdminsHelper
  before_action :authenticate_user!
  before_action :set_all_meetings

  def index
    @user = current_user
    @submittedforms = Form.where(submitted: true)
    @incompleteforms = Form.where(submitted: [false, nil])
 
    respond_to do |format|
     format.html { render partial: 'meetings/calendar', locals: { meetings: @meetings } if request.xhr? }
     format.json { render json: @meetings }
    end
 
     sort_field = params[:sort]
     if sort_field.present?
       case sort_field
       when 'name'
         @submittedforms = @submittedforms.order(:first_name, :last_name)
         @incompleteforms = @incompleteforms.order(:first_name, :last_name)
       when 'gender'
         @submittedforms = @submittedforms.order(:gender)
         @incompleteforms = @incompleteforms.order(:gender)
       when 'application_status'
         @submittedforms = @submittedforms.order(:application_status)
         @incompleteforms = @incompleteforms.order(:application_status)
       when 'address'
         @submittedforms = @submittedforms.order(:address)
         @incompleteforms = @incompleteforms.order(:address)
       when 'start_date'
         @submittedforms = @submittedforms.order(:start_date)
         @incompleteforms = @incompleteforms.order(:start_date)
       when 'end_date'
         @submittedforms = @submittedforms.order(:end_date)
         @incompleteforms = @incompleteforms.order(:end_date)
       when 'nok_name'
         @incompleteforms = @incompleteforms.order(:nok_first_name, :nok_last_name)
       end
     end
   end

  def search
    @query = params[:query]
    @forms = Form.where("first_name LIKE :query OR last_name LIKE :query OR CONCAT(first_name, ' ', last_name) LIKE :query OR 
                        nok_first_name LIKE :query OR nok_last_name LIKE :query OR CONCAT(nok_first_name, ' ', nok_last_name) LIKE :query", query: "%#{@query}%")
    @user = current_user

    sort_field = params[:sort]
    if sort_field.present?
      case sort_field
      when 'name'
        @forms = @forms.order(:first_name, :last_name)
      when 'gender'
        @forms = @forms.order(:gender)
      when 'status'
        @forms = @forms.order(:application_status)
      when 'address'
        @forms = @forms.order(:address)
      when 'start_date'
        @forms = @forms.order(:start_date)
      when 'end_date'
        @forms = @forms.order(:end_date)
      when 'nok_name'
        @forms = @forms.order(:nok_first_name, :nok_last_name)
      end
    end

    @submittedforms = @forms.where(submitted: true)
    @incompleteforms = @forms.where(submitted: [false, nil])
    @no_results = @forms.empty?

    render :index
  end

  def client_profile
    @form = Form.find(params[:id])
    @meetings = Meeting.all
  end

  def _physical_assessment
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text
  end

  def update_physical_assessment
    @form = Form.find(params[:id])

    case params[:commit]
    when 'Save'
      if @form.update(physical_assessment_params)
        redirect_to client_profile_form_path(status: 'Pending Assessment'), notice: 'Physical Assessment Updated'
      end
    when 'Back'
      redirect_to @form, notice: 'Physical Assessment Updated'
    else
      redirect_to physical_assessment_path, alert: 'Invalid action.'
    end
  end

  def _mental_assessment
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text
  end

  def update_mental_assessment
    @form = Form.find(params[:id])

    case params[:commit]
    when 'Save'
      if @form.update(mental_assessment_params)
        redirect_to client_profile_form_path(status: 'Pending Assessment'), notice: 'Mental Assessment Updated'

      end
    when 'Back'
      redirect_to @form, notice: 'Mental Assessment Updated'
    else
      redirect_to mental_assessment_path, alert: 'Invalid action.'
    end
  end

  def _environment_assessment
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text
  end

  def update_environment_assessment
    @form = Form.find(params[:id])

    case params[:commit]
    when 'Save'
      if @form.update(environment_assessment_params)
        redirect_to client_profile_form_path(status: 'Pending Assessment'), notice: 'Environmental Assessment Updated'
      end
    when 'Back'
      redirect_to @form, notice: 'Environmental Assessment Updated'
    else
      redirect_to environment_assessment_path, alert: 'Invalid action.'
    end
  end

  def physical_assessment_params
    permitted_params = params.require(:form).permit(:physical_assessment)
    if params[:form][:physical_assessment] == "Detailed Assessment Needed"
      permitted_params[:physical_assessment] = params[:form][:others_text]
    end
    permitted_params
  end

  def mental_assessment_params
    permitted_params = params.require(:form).permit(:mental_assessment)
    if params[:form][:mental_assessment] == "Detailed Assessment Needed"
      permitted_params[:mental_assessment] = params[:form][:others_text]
    end
    permitted_params
  end

  def environment_assessment_params
    permitted_params = params.require(:form).permit(:environment_assessment)
    if params[:form][:environment_assessment] == "Detailed Assessment Needed"
      permitted_params[:environment_assessment] = params[:form][:others_text]
    end
    permitted_params
  end

  def set_all_meetings
    @meetings = Meeting.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    )
    @meeting = Meeting.new
  end

end