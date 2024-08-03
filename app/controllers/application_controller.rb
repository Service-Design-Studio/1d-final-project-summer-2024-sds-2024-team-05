class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def after_sign_in_path_for(resource)
        if resource.is_a?(User) && resource.admin?
            admin_root_path
        else
            Rails.logger.debug "Redirecting to user_root_path for #{resource.email}"
            user_root_path
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_first_name, :user_last_name, :user_contact_number, :user_address, :user_postal])
        devise_parameter_sanitizer.permit(:account_update, keys: [:user_first_name, :user_last_name, :user_contact_number, :user_address, :user_postal])
    end

    def update
        @form = Form.find(params[:id])
        if @form.update(form_params)
          redirect_to client_profile_form_path, notice: 'Assessment was successfully updated.' # Adjust the redirect as necessary
        else
          render :edit
        end
      end

      private

      def form_params
        params.require(:form).permit(:physical_assessment_detail, :mental_assessment_detail, :environment_assessment_detail)
      end
end
