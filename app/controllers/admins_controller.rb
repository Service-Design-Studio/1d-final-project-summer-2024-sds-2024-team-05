class AdminsController < ApplicationController
  include AdminsHelper
  before_action :authenticate_user!

  def index
    @user = current_user
    @submittedforms = Form.where(submitted: true)
    @incompleteforms = Form.where(submitted: [false, nil])
 
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

  def search
    @query = params[:query]
    @forms = Form.where("first_name LIKE :query OR last_name LIKE :query OR CONCAT(first_name, ' ', last_name) LIKE :query OR 
                        nok_first_name LIKE :query OR nok_last_name LIKE :query OR CONCAT(nok_first_name, ' ', nok_last_name) LIKE :query", query: "%#{@query}%")
    @user = current_user
    @submittedforms = @forms.where(submitted: true)
    @incompleteforms = @forms.where(submitted: [false, nil])
    render :index
  end

end