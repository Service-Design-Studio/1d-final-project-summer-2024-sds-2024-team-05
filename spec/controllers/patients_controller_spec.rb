require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, email: "nursejoon@ninkatec.com", admin: true) }
  
  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'when Save button is clicked' do
      it 'successfully saves the form and redirects to edit_1 path' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe', start_date: Date.today)
        post :create, params: { form: form_params, commit: 'Save' }
        expect(response).to redirect_to(edit_1_form_path(Form.last))
        expect(Form.count).to eq(1) # Assuming one form is created
      end

      context 'when the user is an admin' do
        before do
          sign_out user
          sign_in admin
        end

        it 'transfers the form to a new user if nok_email is present' do
          form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe', nok_email: 'test@gmail.com', start_date: Date.today)
          expect_any_instance_of(Form).to receive(:transfer_to_new_user).with(:nok_email).and_return(true)
          post :create, params: { form: form_params, commit: 'Save' }
          expect(response).to redirect_to(edit_1_form_path(Form.last))
        end
      end
    end

    context 'when Next button is clicked' do
      it 'successfully saves the form and redirects to edit_2 path' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe', start_date: Date.today)
        post :create, params: { form: form_params, commit: 'Next' }
        expect(response).to redirect_to(edit_2_form_path(Form.last))
      end

      it 'redirects to edit_2_forms_path if form data is missing' do
        post :create, params: { form: {}, commit: 'Next' }
        expect(response).to redirect_to(edit_2_forms_path)
      end
    end
  end
end