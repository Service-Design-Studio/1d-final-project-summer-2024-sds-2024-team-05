class AdminsController < ApplicationController
  include AdminsHelper
  before_action :authenticate_user!
  before_action :set_all_meetings

  def index
   @user = current_user
   @newforms = Form.where(last_viewed: nil)
   @changedforms = Form.where.not(last_viewed: nil).where('last_edit > last_viewed')
   # Get IDs of new and changed forms
   excluded_forms_ids = @newforms.or(@changedforms).pluck(:id)
   @submittedforms = Form.where(submitted: true).where.not(id: excluded_forms_ids)
   @incompleteforms = Form.where(submitted: [false, nil])
   @all_submitted_forms = @newforms + @changedforms + @submittedforms

   respond_to do |format|
    format.html { render partial: 'meetings/calendar', locals: { meetings: @meetings } if request.xhr? }
    format.json { render json: @meetings }
   end

    sort_field = params[:sort]
    sort_direction = params[:direction] || 'asc'

    if sort_field.present?
      @all_submitted_forms = Form.where(submitted: true)
      case sort_field
      when 'name'
        @all_submitted_forms = @all_submitted_forms.order("first_name #{sort_direction}, last_name #{sort_direction}")
        @incompleteforms = @incompleteforms.order("first_name #{sort_direction}, last_name #{sort_direction}")
      when 'gender'
        @all_submitted_forms = @all_submitted_forms.order("gender #{sort_direction}")
        @incompleteforms = @incompleteforms.order("gender #{sort_direction}")
      when 'action_required'
        @all_submitted_forms = @all_submitted_forms.order("application_status #{sort_direction}")
        @incompleteforms = @incompleteforms.order("application_status #{sort_direction}")
      when 'address'
        @all_submitted_forms = @all_submitted_forms.order("address #{sort_direction}")
        @incompleteforms = @incompleteforms.order("address #{sort_direction}")
      when 'start_date'
        @all_submitted_forms = @all_submitted_forms.order("start_date #{sort_direction}")
        @incompleteforms = @incompleteforms.order("start_date #{sort_direction}")
      when 'end_date'
        @all_submitted_forms = @all_submitted_forms.order("end_date #{sort_direction}")
        @incompleteforms = @incompleteforms.order("end_date #{sort_direction}")
      when 'nok_name'
        @incompleteforms = @incompleteforms.order("nok_first_name #{sort_direction}, nok_last_name #{sort_direction}")
      end
    end
  end

  def search
    @query = params[:query]
    @forms = Form.where("first_name LIKE :query OR last_name LIKE :query OR CONCAT(first_name, ' ', last_name) LIKE :query OR 
                        nok_first_name LIKE :query OR nok_last_name LIKE :query OR CONCAT(nok_first_name, ' ', nok_last_name) LIKE :query", query: "%#{@query}%")
    @user = current_user

    sort_field = params[:sort]
    sort_direction = params[:direction] || 'asc'

    if sort_field.present?
      case sort_field
      when 'name'
        @forms = @forms.order("first_name #{sort_direction}, last_name #{sort_direction}")
      when 'gender'
        @forms = @forms.order("gender #{sort_direction}")
      when 'application_status'
        @forms = @forms.order("application_status #{sort_direction}")
      when 'address'
        @forms = @forms.order("address #{sort_direction}")
      when 'start_date'
        @forms = @forms.order("start_date #{sort_direction}")
      when 'end_date'
        @forms = @forms.order("end_date #{sort_direction}")
      when 'nok_name'
        @forms = @forms.order("nok_first_name #{sort_direction}, nok_last_name #{sort_direction}")
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