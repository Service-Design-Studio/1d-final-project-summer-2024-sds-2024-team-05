class PatientsController < ApplicationController
   before_action :set_form, only: [:show, :edit_1, :update_1, :edit_2, :update_2, :edit_3, :update_3, :edit_4, :update_4, :edit_5, :update_5]

  def index
    @forms = Form.select(:id, :first_name, :last_name, :start_date, :submitted)
    @form = Form.new
    session[:form_origin] = 'index'
  end

  # Step 1 of form creation
  def new
    @form = Form.new
    session[:form_origin] = 'new'
  end

  # Save step 1 form data and move to step 2
  def create
    case params[:commit]
    when 'Save'
      @form = Form.new(form_params_step1)
      if @form.save
        session[:form_origin] = 'new'
        redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = Form.new(form_params_step1)
        if @form.save
          redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      else
        redirect_to edit_2_forms_path, notice: 'Step 1 of form creation was successfully saved.'
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
      @form = Form.new(form_params_step1)
      if @form.save
        session[:form_origin] = 'new'
        redirect_to edit_1_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = Form.new(form_params_step1)
        if @form.save
          redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
        end
      else
        redirect_to edit_2_forms_path, notice: 'Step 1 of form creation was successfully saved.'
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
        @form = Form.new(form_params_step2)
        if @form.save
          session[:form_origin] = 'new'
          redirect_to edit_2_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
        end
      when 'Next'
        if params[:form].present? && params[:form].values.any?(&:present?)
          @form = Form.new(form_params_step2)
          if @form.save
            redirect_to edit_3_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
          end
        else
          redirect_to edit_3_forms_path, notice: 'Step 2 of form creation was successfully saved.'
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
      @form = Form.new(form_params_step3)
      if @form.save
        session[:form_origin] = 'new'
        redirect_to edit_3_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
      end
    when 'Next'
      if params[:form].present? && params[:form].values.any?(&:present?)
        @form = Form.new(form_params_step3)
        if @form.save
          redirect_to edit_4_form_path(@form), notice: 'Step 2 of form creation was successfully saved.'
        end
      else
        redirect_to edit_4_forms_path, notice: 'Step 2 of form creation was successfully saved.'
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
    puts 'test'
    Rails.logger.debug "params[:commit]: #{params[:commit]}"
    Rails.logger.debug "params[:form]: #{params[:form]}"

    case params[:commit]
    when 'Upload Physical Video'
      if params[:form].present? && params[:form][:physical_video].present?
        @form.physical_video.attach(params[:form][:physical_video])
      end
      # Redirect or render to update view to show the uploaded file
      redirect_to edit_4_form_path(@form), notice: 'Physical video uploaded successfully.'
    when 'Upload Mental Video'
      if params[:form].present? && params[:form][:mental_video].present?
        @form.mental_video.attach(params[:form][:mental_video])
      end
      # Redirect or render to update view to show the uploaded file
      redirect_to edit_4_form_path(@form), notice: 'Mental video uploaded successfully.'
    when 'Save'
      if params[:form].present?
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
      end
      redirect_to edit_4_form_path(@form)
    when 'Next'
      if params[:form].present?
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
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
        @form = Form.new(form_params_step4)
        @form.save
        @form.physical_video.attach(params[:form][:physical_video])
        # Redirect or render to update view to show the uploaded file
        redirect_to edit_4_form_path(@form), notice: 'Physical video uploaded successfully.'
      end
    when 'Upload Mental Video'
      if params[:form].present? && params[:form][:mental_video].present?
        @form = Form.new(form_params_step4)
        @form.save
        @form.mental_video.attach(params[:form][:mental_video])
        # Redirect or render to update view to show the uploaded file
        redirect_to edit_4_form_path(@form), notice: 'Mental video uploaded successfully.'
      end
    when 'Save'
      @form = Form.new()
      @form.save
      if params[:form].present?
        @form.mental_video.attach(params[:form][:mental_video]) if params[:form][:mental_video].present?
        @form.physical_video.attach(params[:form][:physical_video]) if params[:form][:physical_video].present?
      end
      redirect_to edit_4_form_path(@form)
    when 'Next'
      if params[:form].present?
        @form = Form.new(form_params_step4)
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
      if params[:form].present? && params[:form][:environment_video].present?
        @form.environment_video.attach(params[:form][:environment_video])
        redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
      end
    when 'Save'
      if params[:form].present? && params[:form][:environment_video].present?
        @form.environment_video.attach(params[:form][:environment_video])
        redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
      end
    when 'Next'
      if params[:form].present?
        @form.environment_video.attach(params[:form][:environment_video]) if params[:form][:environment_video].present?
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
        @form.environment_video.attach(params[:form][:environment_video])
        redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
      end
    when 'Save'
      @form = Form.new()
      @form.save
      if params[:form].present? && params[:form][:environment_video].present?
        @form.environment_video.attach(params[:form][:environment_video])
        redirect_to edit_5_form_path(@form), notice: 'Environment video uploaded successfully.'
      end
      redirect_to edit_4_form_path(@form)
    when 'Next'
      if params[:form].present?
        @form = Form.new(form_params_step4)
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
      redirect_to forms_path, notice: 'Form submitted successfully.'
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
      Form.find(params[:id])
    else
      Form.new
    end
  end

  def form_params
    params.require(:form).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :relationship, :hobbies, :height, :weight, :conditions, :medication, :services, :start_date, :end_date)

  end
  def form_params_step1
    permitted_params = params.require(:form).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :hobbies, :relationship, :others_text)

    # Check if 'Others' is selected for relationship
    if params[:form][:relationship] == "Others"
      permitted_params[:relationship] = params[:form][:others_text]
    end

    permitted_params
  end

  def form_params_step2
    params.require(:form).permit(:height, :weight, :conditions, :medication, :hospital, :discharge_summary)
  end

  def form_params_step3
    params.require(:form).permit(:services, :start_date, :end_date)
  end

  def form_params_step4
    params.require(:form).permit(:physical_video, :mental_video)
  end

  def form_params_step5
    params.require(:form).permit(:environment_video)
  end

end
