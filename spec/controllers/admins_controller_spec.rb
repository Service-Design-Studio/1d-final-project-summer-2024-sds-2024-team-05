require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

  let(:admin) {  User.find_by(email: "nursejoon@ninkatec.com") }
  let(:user) { create(:user) }
  let!(:form) { create(:form, user: user) }

  before do
    sign_in admin
  end

  describe "GET /index" do
    it "Signed in user renders a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "Signed out user renders an unsuccessful response" do
      sign_out admin
      get :index
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #index with sorting params' do
  let(:usertest) { create(:user, email:"testing555@gmail.com") }
  let!(:form1) { create(:form, user: usertest, first_name: 'Alice', last_name: 'Smith', gender: 'Female', address: '123 Main St', start_date: Date.today, end_date: Date.tomorrow, submitted: true) }
  let!(:form2) { create(:form, user: usertest, first_name: 'Bob', last_name: 'Johnson', gender: 'Male', address: '456 Elm St', start_date: Date.yesterday, end_date: Date.today, submitted: true) }
  let!(:form3) { create(:form, user: usertest, first_name: 'Charlie', last_name: 'Williams', gender: 'Male', address: '789 Oak St', start_date: Date.tomorrow, end_date: Date.tomorrow+1, submitted: false) }

    context 'when no sorting parameters are provided' do
      it 'returns all forms sorted by default order' do
        get :index
        expect(assigns(:all_submitted_forms)).to eq([form1, form2])
      end
    end

    context 'when sorting by name' do
      it 'returns forms sorted by first name and last name' do
        get :index, params: { sort: 'name', direction: 'asc' }
        expect(assigns(:all_submitted_forms)).to eq([form1, form2])
      end

      it 'returns forms sorted by last name and first name in descending order' do
        get :index, params: { sort: 'name', direction: 'desc' }
        expect(assigns(:all_submitted_forms)).to eq([form2, form1])
      end
    end

    context 'when sorting by gender' do
      it 'returns forms sorted by gender' do
        get :index, params: { sort: 'gender', direction: 'asc' }
        expect(assigns(:all_submitted_forms)).to eq([form1, form2])
      end
    end

    context 'when sorting by address' do
      it 'returns forms sorted by address' do
        get :index, params: { sort: 'address', direction: 'asc' }
        expect(assigns(:all_submitted_forms)).to eq([form1, form2])
      end
    end

    context 'when sorting by start_date' do
      it 'returns forms sorted by start date' do
        get :index, params: { sort: 'start_date', direction: 'asc' }
        expect(assigns(:all_submitted_forms)).to eq([form2, form1])
      end
    end

    context 'when sorting by end_date' do
      it 'returns forms sorted by end date' do
        get :index, params: { sort: 'end_date', direction: 'asc' }
        expect(assigns(:all_submitted_forms)).to eq([form2, form1])
      end
    end

    context 'when sorting with invalid parameters' do
      it 'returns forms without sorting' do
        get :index, params: { sort: 'invalid_field', direction: 'asc' }
        expect(assigns(:all_submitted_forms)).to eq([form1, form2])
      end
    end
  end

  describe 'GET #client_profile' do
    it 'assigns the requested form to @form' do
      get :client_profile, params: { id: form.id }
      expect(assigns(:form)).to eq(form)
      # expect(assigns(:meetings)).to be_present
    end

    it 'renders the client_profile template' do
      get :client_profile, params: { id: form.id }
      expect(response).to render_template(:client_profile)
    end
  end

#-----------------------------------------------------------------------#


  describe 'GET #client_profile' do
    it 'assigns the requested form and meetings' do
      get :client_profile, params: { id: form.id }
      expect(assigns(:form)).to eq(form)
      expect(assigns(:meetings)).to eq(Meeting.all)
    end
  end

  describe 'PATCH #update_client_profile' do
    context 'with valid params' do
      it 'updates the form and redirects to the client profile' do
        pdf_file_path = Rails.root.join('spec/fixtures/files/test.pdf')
        patch :update_client_profile, params: { id: form.id, form: { service_agreement_form: Rack::Test::UploadedFile.new(pdf_file_path, 'application/pdf') } }
        expect(response).to redirect_to(client_profile_form_path(form, status: 'Upload Service Agreement'))
      end
    end

    context 'with invalid params' do
      it 'redirects to the client profile with an error notice' do
        patch :update_client_profile, params: { id: form.id, form: { service_agreement_form: nil } }
        expect(response).to redirect_to(client_profile_form_path(form, status: 'Upload Service Agreement'))
      end
    end
  end

  describe 'PATCH #update_physical_assessment' do
    context 'when Save is clicked' do
      it 'updates the physical assessment and redirects with a notice' do
        patch :update_physical_assessment, params: { id: form.id, commit: 'Save', form: { physical_assessment: 'Updated' } }
        expect(response).to redirect_to(client_profile_form_path(form, status: 'Pending Assessment'))
      end
    end

    context 'when Back is clicked' do
      it 'redirects to the form' do
        patch :update_physical_assessment, params: { id: form.id, commit: 'Back' }
        expect(response).to redirect_to(form_path(form))
      end
    end
  end

  describe 'PATCH #update_mental_assessment' do
    context 'when Save is clicked' do
      it 'updates the mental assessment and redirects with a notice' do
        patch :update_mental_assessment, params: { id: form.id, commit: 'Save', form: { mental_assessment: 'Updated' } }
        expect(response).to redirect_to(client_profile_form_path(form, status: 'Pending Assessment'))
      end
    end

    context 'when Back is clicked' do
      it 'redirects to the form' do
        patch :update_mental_assessment, params: { id: form.id, commit: 'Back' }
        expect(response).to redirect_to(form_path(form))
      end
    end
  end

  describe 'PATCH #update_environment_assessment' do
    context 'when Save is clicked' do
      it 'updates the environment assessment and redirects with a notice' do
        patch :update_environment_assessment, params: { id: form.id, commit: 'Save', form: { environment_assessment: 'Updated' } }
        expect(response).to redirect_to(client_profile_form_path(form, status: 'Pending Assessment'))
      end
    end

    context 'when Back is clicked' do
      it 'redirects to the form' do
        patch :update_environment_assessment, params: { id: form.id, commit: 'Back' }
        expect(response).to redirect_to(form_path(form))
      end
    end
  end

end