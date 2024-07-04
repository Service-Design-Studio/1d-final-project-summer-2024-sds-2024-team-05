class PatientsController < ApplicationController
   before_action :set_form, only: [:show, :edit_1, :update_1, :edit_2, :update_2, :edit_3, :update_3, :edit_4, :update_4, :edit_5, :update_5]
   before_action :check_valid_params, only: [:show]
   before_action :authenticate_user!

  def show
    @form = Form.includes(:user).find(params[:id])
  end

  def index
    @forms = current_user.forms.select(:id, :first_name, :last_name, :start_date, :submitted)
    @form = current_user.forms.build
    @user = current_user
    session[:form_origin] = 'index'
  end

  def dashboard
    @submittedforms = Form.where(submitted: true)
    @incompleteforms = Form.where(submitted: [false, nil])
    @user = current_user
    session[:form_origin] = 'index'
  end

  # Step 1 of form creation
  def new
    @form = current_user.forms.build
    session[:form_origin] = 'new'
    @valid_button_1_class, @valid_button_2_class, @valid_button_3_class, @valid_button_4_class, @valid_button_5_class = "btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue"

  end

  # Save step 1 form data and move to step 2
  def create
    case params[:commit]
    when 'Save'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          session[:form_origin] = 'new'
          redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      else
        redirect_to edit_2_forms_path
      end
    else
      render :new
    end
  end

  # GET /forms/1/edit_1
  def edit_1
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit
  end

  # PATCH /forms/1/update_1
  def update_1
    case params[:commit]
    when 'Save'
      if @form.update(form_params_step1)
        redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
      end
    when 'Next'
      if @form.update(form_params_step1)
        redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
      end
    else
      render :edit_1
    end
  end
  
  #collection update 1
  def update_1_collection
    case params[:commit]
    when 'Save'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          session[:form_origin] = 'new'
          redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      else
        redirect_to edit_2_forms_path
      end
    else
      render :edit_1
    end
  end

  # GET /forms/1/edit_2
  def edit_2
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit
  end

  # PATCH /forms/1/update_2
  def update_2
    case params[:commit]
    when 'Save'
      if @form.update(form_params_step2)
        redirect_to edit_2_form_path(@form), notice: 'Form 2 was successfully updated.'
      end
    when 'Next'
      if @form.update(form_params_step2)
        redirect_to edit_3_form_path(@form), notice: 'Form 2 was successfully updated.'
      end
    else
      render :edit_2
    end
  end

    #collection update 2
    def update_2_collection
      case params[:commit]
      when 'Save'
        if params[:form].present? && params[:form].values.any?(&:present?)
          @form = current_user.forms.build(form_params_step2)
          if @form.save
            session[:form_origin] = 'new'
            redirect_to edit_2_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
          end
        end
      when 'Next'
        if params[:form].present? && params[:form].values.any?(&:present?)
          @form = current_user.forms.build(form_params_step2)
          if @form.save
            redirect_to edit_3_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
          end
        else
          redirect_to edit_3_forms_path
        end
      else
        render :edit_2
      end
    end

  # GET /forms/1/edit_3
  def edit_3
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit
  end

  # PATCH /forms/1/update_3
  def update_3
    case params[:commit]
    when 'Save'
      if @form.update(form_params_step3)
        redirect_to edit_3_form_path(@form), notice: 'Form 3 was successfully updated.'
      end
    when 'Next'
      if @form.update(form_params_step3)
        redirect_to edit_4_form_path(@form), notice: 'Form 3 was successfully updated.'
      end
    else
      render :edit_3
    end
  end

  #collection update 1
  def update_3_collection
    case params[:commit]
    when 'Save'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = current_user.forms.build(form_params_step3)
        if @form.save
          session[:form_origin] = 'new'
          redirect_to edit_3_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
        end
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = current_user.forms.build(form_params_step3)
        if @form.save
          redirect_to edit_4_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
        end
      else
        redirect_to edit_4_forms_path
      end
    else
      render :edit_3
    end
  end

  # GET /forms/1/edit_4
  def edit_4
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit

  end

# PATCH /forms/1/update_4
  def update_4
    Rails.logger.debug "params[:commit]: #{params[:commit]}"
    Rails.logger.debug "params[:form]: #{params[:form]}"

    case params[:commit]
    when 'Upload Physical Video'
      if @form.update(form_params_step4)
        if params[:form].present? && params[:form][:physical_video].present?
          @form.physical_video.attach(params[:form][:physical_video])
        end
      # Redirect or render to update view to show the uploaded file
        redirect_to edit_4_form_path(@form), notice: 'Physical video uploaded successfully.'
      end
    when 'Upload Mental Video'
      if @form.update(form_params_step4)
        if params[:form].present? && params[:form][:mental_video].present?
          @form.mental_video.attach(params[:form][:mental_video])
        end
        # Redirect or render to update view to show the uploaded file
        redirect_to edit_4_form_path(@form), notice: 'Mental video uploaded successfully.'
      end
    when 'Save'
      if @form.update(form_params_step4)
        if params[:form].present?
          @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
          @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
        end
        redirect_to edit_4_form_path(@form)
      end
    when 'Next'
      if params[:form].present?
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
        if form_params_step4.present?
          @form.update(form_params_step4)
        end
      end

    redirect_to edit_5_form_path(@form)
    else
      # Handle unexpected values for params[:commit]
      redirect_to edit_4_form_path(@form), alert: 'Invalid action.'
    end
  end

  #collection update 1
  def update_4_collection
    case params[:commit]
    when 'Upload Physical Video'
      if params[:form].present? && params[:form][:physical_video].present?
        @form = current_user.forms.build(form_params_step4)
        @form.save
        @form.physical_video.attach(params[:form][:physical_video])
        # Redirect or render to update view to show the uploaded file
        redirect_to edit_4_form_path(@form), notice: 'Physical video uploaded successfully.'
      end
    when 'Upload Mental Video'
      if params[:form].present? && params[:form][:mental_video].present?
        @form = current_user.forms.build(form_params_step4)
        @form.save
        @form.mental_video.attach(params[:form][:mental_video])
        # Redirect or render to update view to show the uploaded file
        redirect_to edit_4_form_path(@form), notice: 'Mental video uploaded successfully.'
      end
    when 'Save'
      if params[:form].present?
        @form = current_user.forms.build(form_params_step4)
        @form.save
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
        redirect_to edit_4_form_path(@form)
      end
    when 'Next'
      if params[:form].present?
        @form = current_user.forms.build(form_params_step4)
        @form.save
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
        redirect_to edit_5_form_path(@form)
      else
        redirect_to edit_5_forms_path
      end
    else
      # Handle unexpected values for params[:commit]
      render :edit_4
    end
  end

  # GET /forms/1/edit_5
  def edit_5
    @form_origin_text = determine_form_origin_text # Changes my header based on my origin new or edit

  end

  # PATCH /forms/1/update_5
  def update_5
    Rails.logger.debug "params[:commit]: #{params[:commit]}"
    Rails.logger.debug "params[:form]: #{params[:form]}"

    case params[:commit]
    when 'Upload Environment Video'
      if @form.update(form_params_step5)
        if params[:form].present? && params[:form][:environment_video].present?
          @form.environment_video.attach(params[:form][:environment_video])
          redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
        end
      end
    when 'Save'
      if @form.update(form_params_step5)
        if params[:form].present? && params[:form][:environment_video].present?
          @form.environment_video.attach(params[:form][:environment_video])
          redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
        end
#       if params[:form].present? && params[:form][:environment_video].present? #mine
#         @form.environment_video.attach(params[:form][:environment_video])
#         redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
#       end
      end
    when 'Next' #hubert
        if params[:form].present?
          @form.environment_video.attach(params[:form][:environment_video]) if params[:form][:environment_video].present?
          if form_params_step5.present?
            @form.update(form_params_step5)
          end
        end
      redirect_to @form
#     when 'Next' mine
#       if params[:form].present?
#         @form.environment_video.attach(params[:form][:environment_video]) if params[:form][:environment_video].present?
#       end
#       redirect_to @form
    else
      # Handle unexpected values for params[:commit]
      redirect_to edit_5_form_path(@form), alert: 'Invalid action.'
    end
  end

  #collection update 1
  def update_5_collection
    case params[:commit]
    when 'Upload Environment Video'
      if params[:form].present? && params[:form][:environment_video].present?
        @form = current_user.forms.build(form_params_step5)
        @form.save
        @form.environment_video.attach(params[:form][:environment_video])
        redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
      end
    when 'Save'
      if params[:form].present? && params[:form][:environment_video].present?
        @form = current_user.forms.build(form_params_step5)
        @form.save
        @form.environment_video.attach(params[:form][:environment_video])
        redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
      end
    when 'Next'
      if params[:form].present?
        @form = current_user.forms.build(form_params_step5)
        @form.save
        @form.environment_video.attach(params[:form][:environment_video]) if params[:form][:environment_video].present?
        redirect_to @form
      else
        redirect_to show_error_forms_path
      end
    else
      # Handle unexpected values for params[:commit]
      render :edit_5
    end
  end

  def update_submission_status
    @form = Form.find(params[:id]) # Find your form

    if @form.update(submitted: true, status: 'Pending Assessment')
      if current_user.admin?
        redirect_to patients_dashboard_path, notice: 'Form submitted successfully.'
      else
        redirect_to forms_path, notice: 'Form submitted successfully.'
      end
    end
  end

  def physical_assessment
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text
  end

  def update_physical_assessment
    @form = Form.find(params[:id])

    case params[:commit]
    when 'Save'
      if @form.update(physical_assessment_params)
        redirect_to edit_physical_assessment_form_path, notice: 'Physical Assessment Updated'
      end
    when 'Back'
      redirect_to @form, notice: 'Physical Assessment Updated'
    else
      redirect_to physical_assessment_path, alert: 'Invalid action.'
    end
  end

  def mental_assessment
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text
  end

  def update_mental_assessment
    @form = Form.find(params[:id])

    case params[:commit]
    when 'Save'
      if @form.update(mental_assessment_params)
        redirect_to edit_mental_assessment_form_path, notice: 'Mental Assessment Updated'
      end
    when 'Back'
      redirect_to @form, notice: 'Mental Assessment Updated'
    else
      redirect_to mental_assessment_path, alert: 'Invalid action.'
    end
  end

  def environment_assessment
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text
  end

  def update_environment_assessment
    @form = Form.find(params[:id])

    case params[:commit]
    when 'Save'
      if @form.update(environment_assessment_params)
        redirect_to edit_environment_assessment_form_path, notice: 'Environmental Assessment Updated'
      end
    when 'Back'
      redirect_to @form, notice: 'Environmental Assessment Updated'
    else
      redirect_to environment_assessment_path, alert: 'Invalid action.'
    end
  end

  def show_error
    render 'show_error'
  end


  def determine_form_origin_text
    if session[:form_origin] == 'new'
      'New Form'
    elsif session[:form_origin] == 'index'
      'Edit Form'
    end
  end


  def destroy
    @form = Form.find(params[:id])
    @form.destroy
    flash[:notice] = "Form for '#{@form.first_name}' deleted."
    redirect_to forms_path
  end

  private

  def set_form
    @form = if params[:id].present?
      # Form.find(params[:id])
      form = Form.find(params[:id])
      Rails.logger.debug "params[:edit]: #{form.edit_2_valid}"
      @valid_button_1_class, @valid_button_2_class, @valid_button_3_class, @valid_button_4_class, @valid_button_5_class = "btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue","btn btn-primary circular-button btn-blue"
      if form.edit_1_valid == false
        @valid_button_1_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.edit_2_valid == false
        @valid_button_2_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.edit_3_valid == false
        @valid_button_3_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.mental_uploaded == false || form.physical_uploaded == false
        @valid_button_4_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.environment_uploaded == false
        @valid_button_5_class = "btn btn-primary circular-button btn-outline-red"
      end
      form
    else
      current_user.forms.build
    end
  end

  def check_valid_params
    if params[:id].present?
      @form = Form.find(params[:id])
      permitted_params = params.permit(:edit_1_valid, :edit_2_valid, :edit_3_valid, :mental_uploaded, :physical_uploaded, :environment_uploaded)
      Form.all_required.each do |required|
        unless @form.public_send(required.to_s) == true
          permitted_params[required.to_sym] = false
        end
      end
      if @form.update(permitted_params)
        flash[notice:] = 'yeah works'
      else
        flash[alert:] = 'ohnoes'
      end
      set_form
    end
  end

  def form_params_step1
    if current_user.admin?
      permitted_params = params.require(:form).permit(:nok_address, :nok_contact_no, :nok_email, :nok_first_name, :nok_last_name, :first_name, :last_name, :gender, :date_of_birth, :address, :hobbies, :relationship, :others_text, :edit_1_valid, :languages_other, languages:[])
    else
      permitted_params = params.require(:form).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :hobbies, :relationship, :others_text, :edit_1_valid, :languages_other, languages:[])
    end

    # Check if 'Others' is selected for relationship
    if params[:form][:relationship] == "Others"
      permitted_params[:relationship] = params[:form][:others_text]
    end
    if params[:form].present? && params[:form].values.any?(&:present?)
      permitted_params[:edit_1_valid] = Form.page1_required.all? { |key| params[:form].key?(key) && permitted_params[key].present? }
      Rails.logger.debug "params[:form]: #{params[:form][:edit_1_valid]}"
    end
    if !current_user.admin?
      permitted_params[:nok_address] = current_user.user_address
      permitted_params[:nok_contact_no] = current_user.user_contact_number
      permitted_params[:nok_email] = current_user.email
      permitted_params[:nok_first_name] = current_user.user_first_name
      permitted_params[:nok_last_name] = current_user.user_last_name
    end

    #permitted_params[:edit_1_valid] = Form.page1_required.all? { |key| params[:form].key?(key) && permitted_params[key].present? }
    
    permitted_params
  end

  def form_params_step2
    permitted_params = params.require(:form).permit(:height, :weight, :medication, :hospital, :discharge_summary, :conditions_other, :edit_2_valid, conditions:[])

    # permitted_params[:edit_2_valid] = Form.page2_required.all? { |key| params[:form].key?(key) && permitted_params[key].present? }
    if params[:form].present? && params[:form].values.any?(&:present?)
      permitted_params[:edit_2_valid] = Form.page2_required.all? { |key| params[:form].key?(key) && permitted_params[key].present? }
    end
    permitted_params
  end

  def form_params_step3
    permitted_params = params.require(:form).permit(:start_date, :end_date, :services_other, :edit_3_valid, services:[])

    # permitted_params[:edit_3_valid] = Form.page3_required.all? { |key| params[:form].key?(key) && permitted_params[key].present? }
    if params[:form].present? && params[:form].values.any?(&:present?)
      permitted_params[:edit_3_valid] = Form.page3_required.all? { |key| params[:form].key?(key) && permitted_params[key].present? }
    end

    permitted_params
  end

  def form_params_step4
    if params[:id].present?
      @form = Form.find(params[:id])
    else
      @form = current_user.forms.build()
    end
    permitted_params = params.require(:form).permit(:physical_video, :mental_video, :physical_uploaded, :mental_uploaded)
    if permitted_params[:physical_video].present? || @form.physical_video.attached?
      permitted_params[:physical_uploaded] = true
    else
      permitted_params[:physical_uploaded] = false
    end

    if permitted_params[:mental_video].present?
      permitted_params[:mental_uploaded] = true
    else
      permitted_params[:mental_uploaded] = false
    end

    permitted_params
  end

  def form_params_step5
    permitted_params = params.require(:form).permit(:environment_video, :environment_uploaded,)
    if permitted_params[:environment_video].present?
      permitted_params[:environment_uploaded] = true
    else
      permitted_params[:environment_uploaded] = false
    end

    permitted_params
  end

  def physical_assessment_params
    if params[:id].present?
      @form = Form.find(params[:id])
    end
    permitted_params = params.require(:form).permit(:physical_assessment, :status)
    if @form.physical_assessment.present? && @form.environment_assessment.present?
      permitted_params[:status] = 'Meeting Date Pending'
    end
    permitted_params
  end

  def mental_assessment_params
    if params[:id].present?
      @form = Form.find(params[:id])
    end
    permitted_params = params.require(:form).permit(:mental_assessment, :status)
    if @form.physical_assessment.present? && @form.environment_assessment.present?
      permitted_params[:status] = 'Meeting Date Pending'
    end
    permitted_params
  end

  def environment_assessment_params
    if params[:id].present?
      @form = Form.find(params[:id])
    end
    permitted_params = params.require(:form).permit(:environment_assessment, :status)

    if @form.physical_assessment.present? && @form.mental_assessment.present?
      permitted_params[:status] = 'Meeting Date Pending'
    end
    permitted_params
  end

  def page_valid?(form_parameters, required_values)
    required_values.all? { |key| form_parameters.key?(key) && form_parameters[key].present? }
  end
end
