class PatientsController < ApplicationController
   include PatientsHelper

   before_action :set_form, only: [:show, :edit_1, :update_1, :edit_2, :update_2, :edit_3, :update_3, :edit_4, :update_4, :edit_5, :update_5]
   before_action :check_valid_params, only: [:show]
   before_action :authenticate_user!

  def show
    @form = Form.includes(:user, :meeting).find(params[:id])
    respond_to do |format|
        format.html
        format.json { render json: @form.to_json(include: :user)}
    end
  end


  def index
    @forms = current_user.forms.select(:id, :first_name, :last_name, :start_date, :submitted)
    @form = current_user.forms.build
    @user = current_user
    session[:form_origin] = 'index'

    respond_to do |format|
      format.html
      format.json { render json: @forms.to_json(include: { meeting: { only: [:id, :title, :location, :start_time] }})}
    end
  end

  # Step 1 of form creation
  def new
    @form = current_user.forms.build
    # session[:form_origin] = 'new'

    respond_to do |format|
      format.html
      format.json { render json: @form.to_json}
    end
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
              # puts 'WOWW'
            else
              # puts ':(('
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
              # puts 'WOWW'
            else
              # puts ':(('
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
    respond_to do |format|
      format.html
      format.json do
        if @form.valid?
          render json: @form.to_json, status: :ok
        else
          render json: {
            error: 'Validation failed',
            messages: @form.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH /forms/1/update_1
  def update_1
    case params[:commit]
    when 'Save'
      if params[:form].present? && params[:form].except(:autofill_address).values.any?(&:present?)
        if @form.update(form_params_step1)
          redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      end
    when 'Next'
      if params[:form].present? && params[:form].except(:autofill_address).values.any?(&:present?)
        if @form.update(form_params_step1)
          redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        else
        redirect_to edit_2_form_path(@form), notice: 'No changes were made.'
        end
      else
        redirect_to edit_2_form_path(@form), notice: 'No changes were made.'
      end
    else
      render :edit_1
    end
  end

  #collection update 1
  def update_1_collection
    case params[:commit]
    when 'Save'
      if params[:form].present? && params[:form].except(:autofill_address).values.any?(&:present?)
        @form = current_user.forms.build(form_params_step1)
        if @form.save
          session[:form_origin] = 'new'
          redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      end
    when 'Next'
      if params[:form].present? && params[:form].except(:autofill_address).values.any?(&:present?)
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
    respond_to do |format|
      format.html
      format.json do
        if @form.valid?
          render json: @form.to_json, status: :ok
        else
          render json: {
            error: 'Validation failed',
            messages: @form.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH /forms/1/update_2
  def update_2
    case params[:commit]
    when 'Save'
      if @form.update(form_params_step2)
        redirect_to edit_2_form_path(@form), notice: 'Form 2 was successfully updated.'
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        if @form.update(form_params_step2)
          redirect_to edit_3_form_path(@form), notice: 'Form 2 was successfully updated.'
        end
      else
        redirect_to edit_3_form_path(@form), notice: 'No changes were made.'
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
    respond_to do |format|
      format.html
      format.json do
        if @form.valid?
          render json: @form.to_json, status: :ok
        else
          render json: {
            error: 'Validation failed',
            messages: @form.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
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
    respond_to do |format|
      format.html
      format.json do
        if @form.valid?
          render json: @form.to_json, status: :ok
        else
          render json: {
            error: 'Validation failed',
            messages: @form.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH /forms/1/update_4
  def update_4
    form_id = params[:form_id]
    @form = Form.find(params[:id])
    Rails.logger.debug "Update 4 action triggered for form ##{@form.id}"
    Rails.logger.debug "Full params: #{params.inspect}"
    changes = params[:patient][:changes].to_s.strip if params[:patient].present?
    case changes
    when 'Upload Physical Video'
      @form.physical_video_file_name = "#{params[:patient][:filename]}.mp4"
      if @form.save
        Rails.logger.debug "Physical video file name updated: #{@form.physical_video_file_name}"
        render json: { success: true, message: 'Physical video uploaded successfully' }
      else
        render json: { error: 'Failed to save physical video' }, status: :unprocessable_entity
      end
    when 'Upload Mental Video'
      @form.mental_video_file_name = "#{params[:patient][:filename]}.mp4"
      if @form.save
        Rails.logger.debug "Mental video file name updated: #{@form.mental_video_file_name}"
        render json: { success: true, message: 'Mental video uploaded successfully' }
      else
        render json: { error: 'Failed to save mental video' }, status: :unprocessable_entity
      end
    when 'Save'
      # if params[:form].present?
        # upload_physical_video(@form, params[:form][:physical_video]) if params[:form][:physical_video].present?
        # upload_mental_video(@form, params[:form][:mental_video]) if params[:form][:mental_video].present?
        # redirect_to edit_4_form_path(@form)
      # end
      
    when 'Next'
      # if params[:form].present?
        # upload_physical_video(@form, params[:form][:physical_video]) if params[:form][:physical_video].present?
        # upload_mental_video(@form, params[:form][:mental_video]) if params[:form][:mental_video].present?
      # end
      # redirect_to edit_5_form_path(@form)
    else
      # redirect_to edit_4_form_path(@form), alert: 'Invalid action.'
    end
  end



  #collection update 1
  def update_4_collection
    @form = current_user.forms.create
    if @form.persisted?
      render json: { success: true, formId: @form.id }
    else
      render json: { success: false, message: "Failed to create new form" }, status: :unprocessable_entity
    end
  end

  # GET /forms/1/edit_5
  def edit_5
    respond_to do |format|
      format.html
      format.json do
        if @form.valid?
          render json: @form.to_json, status: :ok
        else
          render json: {
            error: 'Validation failed',
            messages: @form.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH /forms/1/update_5
  def update_5
    Rails.logger.debug "params[:commit]: #{params[:commit]}"
    Rails.logger.debug "params[:form]: #{params[:form]}"

    form_id = params[:form_id]
    @form = Form.find(params[:id])
    Rails.logger.debug "Update 4 action triggered for form ##{@form.id}"
    Rails.logger.debug "Full params: #{params.inspect}"
    changes = params[:patient][:changes].to_s.strip if params[:patient].present?
    case changes
    when 'Upload Environment Video'
      @form.environment_video_file_name = "#{params[:patient][:filename]}.mp4"
      if @form.save
        Rails.logger.debug "Environment video file name updated: #{@form.physical_video_file_name}"
        render json: { success: true, message: 'Environment video uploaded successfully' }
      else
        render json: { error: 'Failed to save Environment video' }, status: :unprocessable_entity
      end
    when 'Next' 
      # if params[:form].present?
      #   upload_environment_video(@form, params[:form][:environment_video]) if params[:form][:environment_video].present?
      # end
      # redirect_to @form
    else
      # # Handle unexpected values for params[:commit]
      # redirect_to edit_5_form_path(@form), alert: 'Invalid action.'
    end
  end

  #collection update 1
  def update_5_collection
    @form = current_user.forms.create
    if @form.persisted?
      render json: { success: true, formId: @form.id }
    else
      render json: { success: false, message: "Failed to create new form" }, status: :unprocessable_entity
    end
  end

  def update_submission_status
    @form = Form.find(params[:id]) # Find your form
    cv_assessment(@form)

    if @form.update(submitted: true)
      if @form.mental_video_file_name.present?
        @form.transcribe_video_and_update_form(@form.mental_video_file_name)
      end

      if @form.mental_transcription.present?
        @form.update_animal_count
      end
      
      if current_user.admin?
        redirect_to admin_root_path, notice: 'Form submitted successfully.'
      else
        redirect_to forms_path, notice: 'Form submitted successfully.'
      end
    end
  end

  def cv_assessment(form)
    url = "https://ninkatec-cv-oreggozlqa-as.a.run.app/process_video" # Replace with http://127.0.0.1:3002 if development without deployed microservice
    headers = { 'Content-Type' => 'application/json' }
    body = { "file_name": form.physical_video_file_name}.to_json

    response = HTTParty.post(url, headers: headers, body: body, timeout: 600)
    if response.success?
      parsed_response = JSON.parse(response.body)
      result = parsed_response['result']
      if result == true
        form.physical_primary_assessment = "Passed"
      else
        form.physical_primary_assessment = "Failed"
      end
    else
      # Handle error response
      puts "Error: #{response.code} - #{response.message}"
    end
  end

  def show_error
    render 'show_error'
  end

  def generate_signed_url
    filename = params[:filename]
    content_type = params[:content_type]
    form_id = params[:form_id]

    if filename.blank? || content_type.blank?
      render json: { error: "Filename and content type are required" }, status: :unprocessable_entity
      return
    end
    # Generate the new filename for the signed url
    new_filename = "#{filename}.mp4"

    # Initialize Google Cloud Storage service to execute signed url method
    gcs_service = GoogleCloudStorageService.new
    signed_url = gcs_service.generate_signed_url_for_uploading(new_filename)

    render json: { url: signed_url }
  end

  # def upload_physical_video(form, file)
  #   gcs_service = GoogleCloudStorageService.new
  #   filename = "form_#{form.id}_physical_video.mp4"
  #   gcs_service.upload_file(file, filename)
  #   form.physical_video_file_name = filename
  #   form.save
  # end

  # def upload_mental_video(form, file)
  #   gcs_service = GoogleCloudStorageService.new
  #   filename = "form_#{form.id}_mental_video.mp4"
  #   gcs_service.upload_file(file, filename)
  #   form.mental_video_file_name = filename
  #   form.save
  # end

  # def upload_environment_video(form, file)
  #   gcs_service = GoogleCloudStorageService.new
  #   filename = "form_#{form.id}_environment_video.mp4"
  #   gcs_service.upload_file(file, filename)
  #   form.environment_video_file_name = filename
  #   form.save
  # end

  # def determine_form_origin_text
  #   if session[:form_origin] == 'new'
  #     'New Form'
  #   elsif session[:form_origin] == 'index'
  #     'Edit Form'
  #   end
  # end


  def destroy
    @form = Form.find(params[:id])
    if current_user.admin?
      @form.destroy
      
      flash[:notice] = "Form for '#{@form.first_name}' deleted."
  
      respond_to do |format|
        format.html do
          if current_user.admin?
            redirect_to admin_root_path
          else
            redirect_to forms_path
          end
        end
        
        format.json do
          render json: {
            message: "Form deleted successfully",
            form_id: @form.id
          }, status: :ok
        end
      end
    else
      if !@form.submitted
        @form.destroy
        
        flash[:notice] = "Form for '#{@form.first_name}' deleted."

        respond_to do |format|
          format.html do
            if current_user.admin?
              redirect_to admin_root_path
            else
              redirect_to forms_path
            end
          end

          format.json do
            render json: {
              message: "Form deleted successfully",
              form_id: @form.id
            }, status: :ok
          end
        end
      else
        respond_to do |format|
          format.html do
            flash[:alert] = "Failed to delete form."
            redirect_back(fallback_location: forms_path)
          end
          
          format.json do
            render json: {
              error: "Failed to delete form"
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end

  private

  def set_form
    @form = if params[:id].present?
      form = Form.find(params[:id])
      @valid_button_classes = button_classes(form) #method found in helper to set button colour
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
      permitted_params = params.require(:form).permit(:autofill_address, :nok_address, :nok_postal, :nok_contact_no, :nok_email, :nok_first_name, :nok_last_name, :first_name, :last_name, :gender, :date_of_birth, :address, :postal, :hobbies, :relationship, :others_text, :languages_other, languages:[])
    else
      permitted_params = params.require(:form).permit(:autofill_address, :first_name, :last_name, :gender, :date_of_birth, :address, :postal, :hobbies, :relationship, :others_text, :languages_other, languages:[])
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
        permitted_params[:postal] = permitted_params[:nok_postal]
        permitted_params[:autofill_address] = "1"
      else
        permitted_params[:address] = current_user.user_address
        permitted_params[:postal] = current_user.user_postal
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
    params.require(:form).permit(:physical_video, :mental_video, :mental_transcription)
  end

  def form_params_step5
    permitted_params = params.require(:form).permit(:environment_video)
  end

end
