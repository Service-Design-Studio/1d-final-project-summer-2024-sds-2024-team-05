class PatientsController < ApplicationController


   before_action :set_form, only: [:show, :edit_1, :update_1, :edit_2, :update_2, :edit_3, :update_3, :edit_4, :update_4, :edit_5, :update_5]
   before_action :check_valid_params, only: [:show]
   before_action :authenticate_user!
   before_action :set_all_meetings

   def show
    @form = Form.includes(:user).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @form.to_json(include: :user) }
    end
  end
  

  def index
    @forms = current_user.forms.select(:id, :first_name, :last_name, :start_date, :submitted)
    @form = current_user.forms.build
    @user = current_user
    session[:form_origin] = 'index'
  end


def dashboard
   @user = current_user
   @submittedforms = Form.where(submitted: true)
   @incompleteforms = Form.where(submitted: [false, nil])

   respond_to do |format|
    format.html { render partial: 'meetings/calendar', locals: { meetings: @meetings } if request.xhr? }
    format.json { render json: @meetings }
   end

   # Handle sorting for submitted forms based on first name, last name, or address
   if params[:sort] == "alphabetical"
    @submittedforms = @submittedforms.order(Arel.sql("LOWER(first_name || ' ' || last_name) ASC"))
    @incompleteforms = @incompleteforms.order(Arel.sql("LOWER(first_name || ' ' || last_name) ASC"))
   elsif params[:sort_nok_name] == "alphabetical"
     @submittedforms = @submittedforms.order(Arel.sql("LOWER(nok_first_name || ' ' || nok_last_name) ASC"))
     @incompleteforms = @incompleteforms.order(Arel.sql("LOWER(nok_first_name || ' ' || nok_last_name) ASC"))
   elsif params[:sort_address] == "alphabetical"
     @submittedforms = @submittedforms.order("LOWER(address) ASC")
     @incompleteforms = @incompleteforms.order("LOWER(address) ASC")
   end

   # Handle sorting by dates
   if params[:sort_date] == "earliest"
     @submittedforms = @submittedforms.order('start_date ASC')
     @incompleteforms = @incompleteforms.order('start_date ASC')
   elsif params[:sort_end_date] == "earliest"
     @submittedforms = @submittedforms.order('end_date ASC')
     @incompleteforms = @incompleteforms.order('end_date ASC')
   end

   # Handle gender-based sorting independently
   if params[:sort_female]
     @submittedforms = @submittedforms.order(Arel.sql("CASE WHEN gender = 'Female' THEN 0 ELSE 1 END, first_name ASC, last_name ASC"))
     @incompleteforms = @incompleteforms.order(Arel.sql("CASE WHEN gender = 'Female' THEN 0 ELSE 1 END, first_name ASC, last_name ASC"))
   elsif params[:sort_male]
     @submittedforms = @submittedforms.order(Arel.sql("CASE WHEN gender = 'Male' THEN 0 ELSE 1 END, first_name ASC, last_name ASC"))
     @incompleteforms = @incompleteforms.order(Arel.sql("CASE WHEN gender = 'Male' THEN 0 ELSE 1 END, first_name ASC, last_name ASC"))
   end

   if params[:sort_status]
     @submittedforms = @submittedforms.order(Arel.sql("CASE WHEN status = 'Pending Assessment' THEN 0 ELSE 1 END"))
     @incompleteforms = @incompleteforms.order(Arel.sql("CASE WHEN status = 'Pending Assessment' THEN 0 ELSE 1 END"))
   end
 end



  # Step 1 of form creation
  def new
    @form = current_user.forms.build
    session[:form_origin] = 'new'

    @valid_button_1_class, @valid_button_2_class, @valid_button_3_class, @valid_button_4_class, @valid_button_5_class, @valid_button_summ_class = ["btn btn-primary circular-button btn-blue"]*6
  end
  def search
    @query = params[:query]
    @forms = Form.where("first_name LIKE :query OR last_name LIKE :query OR CONCAT(first_name, ' ', last_name) LIKE :query OR 
                        nok_first_name LIKE :query OR nok_last_name LIKE :query OR CONCAT(nok_first_name, ' ', nok_last_name) LIKE :query", query: "%#{@query}%")
    @user = current_user
    @submittedforms = @forms.where(submitted: true)
    @incompleteforms = @forms.where(submitted: [false, nil])
    render :dashboard
  end

  # Save step 1 form data and move to step 2
  def create
    case params[:commit]
    when 'Save'
      if params[:form].present? && params[:form].except(:autofill_address).values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          session[:form_origin] = 'new'
          if current_user.admin? && params[:form][:nok_email].present?
            if @form.transfer_to_new_user(:nok_email)
              puts 'WOWW'
            else
              puts ':(('
            end
          end
          redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      end
    when 'Next'
      if params[:form].present? && params[:form].except(:autofill_address).values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          if current_user.admin?
            if @form.transfer_to_new_user(:nok_email)
              puts 'WOWW'
            else
              puts ':(('
            end
          end
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
      if params[:form].present? && params[:form][:physical_video].present?
        @form.physical_video.attach(params[:form][:physical_video])
        if @form.update(form_params_step4)
        # Redirect or render to update view to show the uploaded file
          redirect_to edit_4_form_path(@form), notice: 'Physical video uploaded successfully.'
        else
          redirect_to edit_4_form_path(@form), notice: 'Video upload unsuccessful.'
        end
      end
    when 'Upload Mental Video'
      if params[:form].present? && params[:form][:mental_video].present?
        @form.mental_video.attach(params[:form][:mental_video])
        if @form.update(form_params_step4)
          # Redirect or render to update view to show the uploaded file
          redirect_to edit_4_form_path(@form), notice: 'Mental video uploaded successfully.'
        else
          redirect_to edit_4_form_path(@form), notice: 'Video upload unsuccessful.'
        end
      end
    when 'Save'
      if params[:form].present?
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
        if @form.update(form_params_step4)
          redirect_to edit_4_form_path(@form), notice: 'Videos uploaded successfully.'
        else
          redirect_to edit_4_form_path(@form), notice: 'Video upload unsuccessful.'
        end
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
    when 'Upload Environment Video', 'Save'
      if params[:form].present? && params[:form][:environment_video].present?
        @form.environment_video.attach(params[:form][:environment_video])
        if @form.update(form_params_step5)
          redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
        else
          redirect_to edit_5_form_path(@form), notice: 'Video upload unsuccessful.'
        end
      end
    # when 'Save'
    #   if params[:form].present? && params[:form][:environment_video].present?
    #     @form.environment_video.attach(params[:form][:environment_video])
    #     if @form.update(form_params_step5)
    #       redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
    #     else
    #       redirect_to edit_5_form_path(@form), notice: 'Video upload unsuccessful.'
    #     end
    #   end
    when 'Next' #hubert
        if params[:form].present?
          @form.environment_video.attach(params[:form][:environment_video]) if params[:form][:environment_video].present?
          if form_params_step5.present?
            @form.update(form_params_step5)
          end
        end
      redirect_to @form
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

    if @form.update(submitted: true)
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

    if current_user.admin?
      redirect_to patients_dashboard_path
    else
      redirect_to forms_path
    end

  end

  private

  def set_form
    @form = if params[:id].present?
      form = Form.find(params[:id])
      @valid_button_1_class, @valid_button_2_class, @valid_button_3_class, @valid_button_4_class, @valid_button_5_class, @valid_button_summ_class =  ["btn btn-primary circular-button btn-blue"]*6   
      if form.pg1_valid == false
        @valid_button_1_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.pg2_valid == false
        @valid_button_2_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.pg3_valid == false
        @valid_button_3_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.pg4_valid == false
        @valid_button_4_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.pg5_valid == false
        @valid_button_5_class = "btn btn-primary circular-button btn-outline-red"
      end
      if form.submittable == false
        @valid_button_summ_class = "btn btn-primary circular-button btn-outline-red"
      end
      form
    else
      current_user.forms.build
    end
  end

  def check_valid_params
    if params[:id].present?
      set_form
      if current_user.admin?
        @form.update_last_viewed
      end
    end
  end

  def form_params_step1
    
    if current_user.admin?
      permitted_params = params.require(:form).permit(:autofill_address, :nok_address, :nok_contact_no, :nok_email, :nok_first_name, :nok_last_name, :first_name, :last_name, :gender, :date_of_birth, :address, :hobbies, :relationship, :others_text, :languages_other, languages:[])
    else
      permitted_params = params.require(:form).permit(:autofill_address, :first_name, :last_name, :gender, :date_of_birth, :address, :hobbies, :relationship, :others_text, :languages_other, languages:[])
    end

    if !current_user.admin?
      permitted_params[:nok_address] = current_user.user_address
      permitted_params[:nok_contact_no] = current_user.user_contact_number
      permitted_params[:nok_email] = current_user.email
      permitted_params[:nok_first_name] = current_user.user_first_name
      permitted_params[:nok_last_name] = current_user.user_last_name
    end

    if permitted_params[:autofill_address] == "1"
      if current_user.admin?
        permitted_params[:address] = permitted_params[:nok_address]
      else
        permitted_params[:address] = current_user.user_address
      end
    end

    # Check if 'Others' is selected for relationship
    if params[:form][:relationship] == "Others"
      permitted_params[:relationship] = params[:form][:others_text]
    end

    if params[:form][:languages].present?
      permitted_params[:languages] = params[:form][:languages].to_s.gsub!(/[\[\]\"]/,"")
    end

    permitted_params
  end

  def form_params_step2
    permitted_params = params.require(:form).permit(:height, :weight, :medication, :hospital, :discharge_summary, :conditions_other, conditions:[])

    if params[:form][:conditions].present?
      permitted_params[:conditions] = params[:form][:conditions].to_s.gsub!(/[\[\]\"]/,"")
    end
    permitted_params
  end

  def form_params_step3
    permitted_params = params.require(:form).permit(:start_date, :end_date, :services_other, services:[])

    if params[:form][:services].present?
      permitted_params[:services] = params[:form][:services].to_s.gsub!(/[\[\]\"]/,"")
    end

    permitted_params
  end

  def form_params_step4
    if params[:id].present?
      @form = Form.find(params[:id])
    else
      @form = current_user.forms.build()
    end
    permitted_params = params.require(:form).permit(:physical_video, :mental_video)
  end

  def form_params_step5
    permitted_params = params.require(:form).permit(:environment_video)
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

  def page_valid?(form_parameters, required_values)
    required_values.all? { |key| form_parameters.key?(key) && form_parameters[key].present? }
  end
  
  def set_all_meetings
    @meetings = Meeting.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    )
    @meeting = Meeting.new
  end
end
