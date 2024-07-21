class AdminsController < ApplicationController
  include AdminsHelper
  before_action :authenticate_user!

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

    render :dashboard
  end

end