class PatientsController < ApplicationController
   before_action :set_form, only: [:show, :edit_1, :update_1, :edit_2, :update_2, :edit_3, :update_3]

  def index
    @forms = Form.select(:id, :first_name, :last_name, :start_date)
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
    @form = Form.new(form_params_step1)
    if @form.save
      redirect_to edit_2_form_path(@form), notice: 'Step 1 of form creation was successfully saved.'
    else
      render :new
    end
  end

  # GET /forms/1/edit_1
  def edit_1
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit
  end

  # PATCH /forms/1/update_1
  def update_1
    @form = Form.find(params[:id])
    if @form.update(form_params_step1)
      redirect_to edit_2_form_path(@form), notice: 'Form 1 was successfully updated.'
    else
      render :edit_1
    end
  end

  # GET /forms/1/edit_2
  def edit_2
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit
  end

  # PATCH /forms/1/update_2
  def update_2
    @form = Form.find(params[:id])
    if @form.update(form_params_step2)
      redirect_to edit_3_form_path(@form), notice: 'Form 2 was successfully updated.'
    else
      render :edit_2
    end
  end

  # GET /forms/1/edit_3
  def edit_3
    @form = Form.find(params[:id])
    @form_origin_text = determine_form_origin_text #Changes my header based on my origin new or edit
  end

  # PATCH /forms/1/update_3
  def update_3
    @form = Form.find(params[:id])
    if @form.update(form_params_step3)
      redirect_to @form, notice: 'Form 3 was successfully updated.'
    else
      render :edit_3
    end
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
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to forms_path
  end

  private

  def set_form
    @form = Form.find(params[:id])
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
    params.require(:form).permit(:height, :weight, :conditions, :medication, :hospital, :discharge_summ)
  end

  def form_params_step3
    params.require(:form).permit(:services, :start_date, :end_date)
  end
end
