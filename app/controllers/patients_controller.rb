class PatientsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  def index
    @forms = Form.select(:id, :first_name, :last_name, :start_date)
    @form = Form.new
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to forms_path, notice: 'Form was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @form.update(form_params)
      redirect_to @form, notice: 'Form was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy
    redirect_to forms_url, notice: 'Form was successfully deleted.'
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def form_params
    params.require(:form).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :relationship, :hobbies, :height, :weight, :conditions, :medication, :services, :start_date, :end_date)
  end
end
