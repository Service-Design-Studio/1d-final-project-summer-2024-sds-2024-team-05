require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:user) { create(:user, email:"testing123@gmail.com") }
  let(:admin) { User.find_by(email: "nursejoon@ninkatec.com") }
  let(:form) { create(:form, user: user) }
  
  before do
    sign_in user
  end

  describe 'GET #index' do
  before { get :index }

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end


  describe 'GET #new' do
  before { get :new }

    it 'assigns a new form' do
      expect(assigns(:form)).to be_a_new(Form)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when Save button is clicked' do
      it 'successfully saves the form and redirects to edit_1 path' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe', start_date: Date.today)
        post :create, params: { form: form_params, commit: 'Save' }
        expect(response).to redirect_to(edit_1_form_path(Form.last))
        expect(Form.count).to eq(1) # Assuming one form is created
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

    context 'when no valid action' do
      it 'renders new' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe')
        post :create, params: { form: form_params, commit: '' }
        expect(Form.count).to eq(0)
        expect(response).to render_template(:new)
      end
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

  describe 'GET #edit_1' do
  before { get :edit_1, params: { id: form.id } }

    it 'assigns the form' do
      expect(assigns(:form)).to eq(form)
    end

    it 'renders the edit_1 template' do
      expect(response).to render_template(:edit_1)
    end
  end

  describe 'PATCH #update_1' do
    context 'when saving' do
      it 'updates the form and redirects to edit_1' do
        patch :update_1, params: { id: form.id, form: { first_name: 'Jacob' }, commit: 'Save' }
        expect(form.reload.first_name).to eq('Jacob')
        expect(response).to redirect_to(edit_1_form_path(form))
      end
    end

    context 'when moving to next step' do
      it 'updates the form and redirects to edit_2' do
        patch :update_1, params: { id: form.id, form: { first_name: 'Jacob' }, commit: 'Next' }
        expect(form.reload.first_name).to eq('Jacob')
        expect(response).to redirect_to(edit_2_form_path(form))
      end
    end
  end

  describe 'PATCH #update_1_collection' do
    context 'when saving' do
      it 'creates and saves a new form, and redirects to edit_1' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe')
        patch :update_1_collection, params: { form: form_params, commit: 'Save' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_1_form_path(Form.last))
      end
    end

    context 'when moving to next step' do
      it 'creates and saves a new form, and redirects to edit_2' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe')
        patch :update_1_collection, params: { form: form_params, commit: 'Next' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_2_form_path(Form.last))
      end

      specify 'if no params, redirect to edit_2_forms_path without saving form' do 
        patch :update_1_collection, params: { form: {}, commit: 'Next' }
        expect(Form.count).to eq(0)
        expect(response).to redirect_to(edit_2_forms_path)
      end
    end

    context 'when no valid action' do
      it 'renders to edit_1' do
        form_params = attributes_for(:form, first_name: 'John', last_name: 'Doe')
        patch :update_1_collection, params: { form: form_params, commit: '' }
        expect(Form.count).to eq(0)
        expect(response).to render_template(:edit_1)
      end
    end
  end


  describe 'GET #edit_2' do
  before { get :edit_2, params: { id: form.id } }

    it 'assigns the form' do
      expect(assigns(:form)).to eq(form)
    end

    it 'renders the edit_1 template' do
      expect(response).to render_template(:edit_2)
    end
  end

  describe 'PATCH #update_2' do
    context 'when saving' do
      it 'updates the form and redirects to edit_2' do
        patch :update_2, params: { id: form.id, form: { height: 180, weight: 50}, commit: 'Save' }
        expect(form.reload.height).to eq(180)
        expect(form.reload.weight).to eq(50)
        expect(response).to redirect_to(edit_2_form_path(form))
      end
    end

    context 'when moving to next step' do
      it 'updates the form and redirects to edit_3' do
        patch :update_2, params: { id: form.id, form: { height: 180, weight: 50}, commit: 'Next' }
        expect(form.reload.height).to eq(180)
        expect(form.reload.weight).to eq(50)
        expect(response).to redirect_to(edit_3_form_path(form))
      end
    end
  end

  describe 'PATCH #update_2_collection' do
    context 'when saving' do
      it 'creates and saves a new form, and redirects to edit_2' do
        form_params = attributes_for(:form, height: 180, weight: 50)
        patch :update_2_collection, params: { form: form_params, commit: 'Save' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_2_form_path(Form.last))
      end
    end

    context 'when moving to next step' do
      it 'creates and saves a new form, and redirects to edit_3' do
        form_params = attributes_for(:form, height: 180, weight: 50)
        patch :update_2_collection, params: { form: form_params, commit: 'Next' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_3_form_path(Form.last))
      end

      specify 'if no params, redirect to edit_3_forms_path without saving form' do 
        patch :update_2_collection, params: { form: {}, commit: 'Next' }
        expect(Form.count).to eq(0)
        expect(response).to redirect_to(edit_3_forms_path)
      end
    end

    context 'when no valid action' do
      it 'renders to edit_2' do
        form_params = attributes_for(:form, height: 180, weight: 50)
        patch :update_2_collection, params: { form: form_params, commit: '' }
        expect(Form.count).to eq(0)
        expect(response).to render_template(:edit_2)
      end
    end
  end

  describe 'GET #edit_3' do
  before { get :edit_3, params: { id: form.id } }

    it 'assigns the form' do
      expect(assigns(:form)).to eq(form)
    end

    it 'renders the edit_1 template' do
      expect(response).to render_template(:edit_3)
    end
  end

  describe 'PATCH #update_3' do
    context 'when saving' do
      it 'updates the form and redirects to edit_3' do
        patch :update_3, params: { id: form.id, form: { services: ["toileting"], start_date: Date.today}, commit: 'Save' }
        expect(form.reload.services).to eq("toileting")
        expect(form.reload.start_date).to eq(Date.today)
        expect(response).to redirect_to(edit_3_form_path(form))
      end
    end

    context 'when moving to next step' do
      it 'updates the form and redirects to edit_4' do
        patch :update_3, params: { id: form.id, form: { services: ["toileting"], start_date: Date.today}, commit: 'Next' }
        expect(form.reload.services).to eq("toileting")
        expect(form.reload.start_date).to eq(Date.today)
        expect(response).to redirect_to(edit_4_form_path(form))
      end
    end
  end

  describe 'PATCH #update_3_collection' do
    context 'when saving' do
      it 'creates and saves a new form, and redirects to edit_3' do
        form_params = attributes_for(:form, services: ["toileting"], start_date: Date.today)
        patch :update_3_collection, params: { form: form_params, commit: 'Save' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_3_form_path(Form.last))
      end
    end

    context 'when moving to next step' do
      it 'creates and saves a new form, and redirects to edit_4' do
        form_params = attributes_for(:form, services: ["toileting"], start_date: Date.today)
        patch :update_3_collection, params: { form: form_params, commit: 'Next' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_4_form_path(Form.last))
      end

      specify 'if no params, redirect to edit_4_forms_path without saving form' do 
        patch :update_3_collection, params: { form: {}, commit: 'Next' }
        expect(Form.count).to eq(0)
        expect(response).to redirect_to(edit_4_forms_path)
      end
    end

    context 'when no valid action' do
      it 'renders to edit_3' do
        form_params = attributes_for(:form, services: ["toileting"], start_date: Date.today)
        patch :update_3_collection, params: { form: form_params, commit: '' }
        expect(Form.count).to eq(0)
        expect(response).to render_template(:edit_3)
      end
    end
  end

  describe 'GET #edit_4' do
  before { get :edit_4, params: { id: form.id } }

    it 'assigns the form' do
      expect(assigns(:form)).to eq(form)
    end

    it 'renders the edit_1 template' do
      expect(response).to render_template(:edit_4)
    end
  end

  describe 'PATCH #update_4' do
    context 'when uploading a physical video' do
      it 'updates the physical video file name and returns success (Needs connection to google cloud bucket with the file present)' do
        patch :update_4, params: {id: form.id, patient: {changes: 'Upload Physical Video', filename: 'sit_stand_2'}}
        form.reload
        expect(form.physical_video_file_name).to eq('sit_stand_2.mp4')
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['success']).to be true
        expect(JSON.parse(response.body)['message']).to eq('Physical video uploaded successfully')
      end
    end

    context 'when uploading a mental video' do
      it 'updates the mental video file name and returns success (Needs connection to google cloud bucket with the file present)' do
        patch :update_4, params: {id: form.id, patient: {changes: 'Upload Mental Video', filename: 'sit_stand_2'}}
        form.reload
        expect(form.mental_video_file_name).to eq('sit_stand_2.mp4')
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['success']).to be true
        expect(JSON.parse(response.body)['message']).to eq('Mental video uploaded successfully')
      end
    end

  end

  describe 'PATCH #update_4_collection' do
    context 'when form is successfully created' do
      it 'returns success: true and the form ID' do
        post :update_4_collection
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
        expect(json_response['formId']).to eq(Form.last.id)
      end
    end

    context 'when form creation fails' do
      before do
        allow_any_instance_of(User).to receive_message_chain(:forms, :create).and_return(Form.new)
      end

      it 'returns success: false and an error message' do
        post :update_4_collection
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be false
        expect(json_response['message']).to eq("Failed to create new form")
      end
    end
  end

  describe 'GET #edit_5' do
  before { get :edit_4, params: { id: form.id } }

    it 'assigns the form' do
      expect(assigns(:form)).to eq(form)
    end

    it 'renders the edit_1 template' do
      expect(response).to render_template(:edit_4)
    end
  end

  describe 'PATCH #update_5' do
    context 'when uploading an environment video' do
      it 'updates the physical video file name and returns success (Needs connection to google cloud bucket with the file present)' do
        patch :update_5, params: {id: form.id, patient: {changes: 'Upload Environment Video', filename: 'sit_stand_2'}}
        form.reload
        expect(form.environment_video_file_name).to eq('sit_stand_2.mp4')
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['success']).to be true
        expect(JSON.parse(response.body)['message']).to eq('Environment video uploaded successfully')
      end
    end
  end

  describe 'PATCH #update_5_collection' do
    context 'when form is successfully created' do
      it 'returns success: true and the form ID' do
        post :update_5_collection
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
        expect(json_response['formId']).to eq(Form.last.id)
      end
    end

    context 'when form creation fails' do
      before do
        allow_any_instance_of(User).to receive_message_chain(:forms, :create).and_return(Form.new)
      end

      it 'returns success: false and an error message' do
        post :update_5_collection
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be false
        expect(json_response['message']).to eq("Failed to create new form")
      end
    end
  end

  describe 'GET #show' do
    context 'when requesting HTML format' do
      before do
        get :show, params: { id: form.id }
      end

      it 'assigns the requested form to @form' do
        expect(assigns(:form)).to eq(form)
      end

      it 'renders the :show template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is an admin' do
      before do
        delete :destroy, params: { id: form.id }
      end

      it 'deletes the form' do
        expect(Form.exists?(form.id)).to be_falsey
      end
    end
  end

  describe 'PATCH @update_submission_status' do
    context 'when user is a user' do
      before do
        sign_in user
      end

      it 'submits the form' do
        patch :update_submission_status, params: { id: form.id}
        expect(response).to redirect_to(forms_path)
      end
    end

    context 'when user is an admin' do
      before do
        sign_out user
        sign_in admin
      end

      it 'deletes the form' do
        patch :update_submission_status, params: { id: form.id}
        expect(response).to redirect_to(admin_root_path)
      end
    end
  end

  describe 'GET #show_error' do
    context 'when requesting HTML format' do
      it 'renders the :show template' do
        get :show_error
        expect(response).to render_template(:show_error)
      end
    end
  end

  describe 'POST #generate_signed_url' do
    let(:filename) { 'test_video' }
    let(:content_type) { 'video/mp4' }
    let(:form_id) { 1 }
    let(:signed_url) { 'https://example.com/signed_url' }

    before do
      allow(GoogleCloudStorageService).to receive_message_chain(:new, :generate_signed_url_for_uploading).and_return(signed_url)
    end

    context 'when filename and content_type are provided' do
      it 'returns a signed URL' do
        post :generate_signed_url, params: { filename: filename, content_type: content_type, id: form_id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        json_response = JSON.parse(response.body)
        expect(json_response['url']).to eq(signed_url)
      end
    end

    context 'when filename is missing' do
      it 'returns an error message' do
        post :generate_signed_url, params: { content_type: content_type, id: form_id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Filename and content type are required')
      end
    end

    context 'when content_type is missing' do
      it 'returns an error message' do
        post :generate_signed_url, params: { filename: filename, id: form_id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Filename and content type are required')
      end
    end

    context 'when both filename and content_type are missing' do
      it 'returns an error message' do
        post :generate_signed_url, params: { id: form_id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Filename and content type are required')
      end
    end
  end
end