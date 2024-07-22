require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  controller(ApplicationController) do
    def after_sign_in_path_for(resource)
      super(resource)
    end

    def devise_parameter_sanitizer
      Devise::ParameterSanitizer.new(User, :user, self)
    end
  end

  describe '#after_sign_in_path_for' do
    context 'when the resource is a regular user' do
      it 'redirects to user_root_path' do
        expect(controller.after_sign_in_path_for(user)).to eq(user_root_path)
      end
    end

    context 'when the resource is an admin' do
      it 'redirects to admin_root_path' do
        expect(controller.after_sign_in_path_for(admin)).to eq(admin_root_path)
      end
    end
  end

  # describe '#configure_permitted_parameters' do
  #   before do
  #     controller.send(:configure_permitted_parameters)
  #   end

  #   it 'permits additional parameters for sign up' do
  #     sanitizer = Devise::ParameterSanitizer.new(User, :user, controller)
  #     permitted_params = sanitizer.permit(:sign_up)

  #     expect(permitted_params[:user]).to include(:user_first_name, :user_last_name, :user_contact_number, :user_address)
  #   end

  #   it 'permits additional parameters for account update' do
  #     sanitizer = Devise::ParameterSanitizer.new(User, :user, controller)
  #     permitted_params = sanitizer.permit(:account_update)

  #     expect(permitted_params[:user]).to include(:user_first_name, :user_last_name, :user_contact_number, :user_address)
  #   end
  # end
end