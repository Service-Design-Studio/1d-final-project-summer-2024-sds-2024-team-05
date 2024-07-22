require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, email: "nursejoon@ninkatec.com", admin: true) }
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
  # before do 
  #   form = create(:form)
  # end
    context 'when uploading a physical video' do
      it 'successfully uploads and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4, params: { id: form.id, form: { physical_video: video }, commit: 'Upload Physical Video' }
        form.reload
        expect(form.physical_video).to be_attached
        expect(response).to redirect_to(edit_4_form_path(form))
      end
      # specify 'if no video param, redirects back to same page without saving' do
      #   patch :update_4, params: { id: form.id, form: {}, commit: 'Upload Physical Video' }
      #   form.reload
      #   expect(form.physical_video).to_not be_attached
      #   expect(response).to redirect_to(edit_4_form_path(form))
      # end
    end

    context 'when uploading a mental video' do
      it 'successfully uploads and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4, params: { id: form.id, form: { mental_video: video }, commit: 'Upload Mental Video' }
        form.reload
        expect(form.mental_video).to be_attached
        expect(response).to redirect_to(edit_4_form_path(form))
      end
    end

    context 'when Save' do
      it 'successfully uploads any params and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4, params: { id: form.id, form: { physical_video: video, mental_video: video }, commit: 'Save' }
        form.reload
        expect(form.mental_video).to be_attached
        expect(form.physical_video).to be_attached
        expect(response).to redirect_to(edit_4_form_path(form))
      end
    end

    context 'when Next' do
      it 'successfully uploads any params and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm1.mp4'), 'video/mp4')
        video2 = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4, params: { id: form.id, form: { physical_video: video, mental_video: video2 }, commit: 'Next' }
        form.reload
        expect(form.mental_video).to be_attached
        expect(form.physical_video).to be_attached
        expect(response).to redirect_to(edit_5_form_path(form))
      end
    end
    # context 'when invalid action' do
    #   it 'redirects to edit_4 page' do
    #     video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
    #     patch :update_4, params: { id: form.id, form: { physical_video: video, mental_video: video }, commit: '' }
    #     form.reload
    #     expect(form.mental_video).to_not be_attached
    #     expect(form.physical_video).to_not be_attached
    #     expect(response).to redirect_to(edit_4_form_path(form))
    #   end
    # end
  end

  describe 'PATCH #update_4_collection' do
    context 'when upload video button' do
      xit 'creates and saves a new form, upload physical video and redirects to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm1.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { physical_video: video }, commit: 'Upload Physical Video' }
        expect(Form.count).to eq(1)
        expect(form.physical_video).to be_attached
        expect(response).to redirect_to(edit_4_form_path(Form.last))
      end

      xit 'creates and saves a new form, upload mental video and redirects to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm1.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { mental_video: video }, commit: 'Upload Mental Video' }
        expect(Form.count).to eq(1)
        expect(form.mental_video).to be_attached
        expect(response).to redirect_to(edit_4_form_path(Form.last))
      end
    end
    context 'when saving' do
      xit 'creates and saves a new form, and redirects to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm1.mp4'), 'video/mp4')
        video2 = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { physical_video: video, mental_video: video2 }, commit: 'Save' }
        expect(Form.count).to eq(1)
        expect(form.physical_video).to be_attached
        expect(form.mental_video).to be_attached
        expect(response).to redirect_to(edit_4_form_path(Form.last))
      end
    end

    context 'when moving to next step' do
      xit 'creates and saves a new form, and redirects to edit_5' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm1.mp4'), 'video/mp4')
        video2 = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { physical_video: video, mental_video: video2 }, commit: 'Next' }
        expect(Form.count).to eq(1)
        expect(form.physical_video).to be_attached
        expect(form.mental_video).to be_attached
        expect(response).to redirect_to(edit_5_form_path(Form.last))
      end

      xspecify 'if no params, redirect to edit_5_forms_path without saving form' do 
        patch :update_4_collection, params: { id: form.id, form: {}, commit: 'Save' }
        expect(Form.count).to eq(0)
        expect(response).to redirect_to(edit_5_forms_path)
      end
    end

    context 'when no valid action' do
      xit 'renders to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { physical_video: video }, commit: '' }
        expect(Form.count).to eq(0)
        expect(response).to render_template(:edit_4)
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
      it 'successfully uploads and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_5, params: { id: form.id, form: { environment_video: video }, commit: 'Upload Environment Video' }
        form.reload
        expect(form.environment_video).to be_attached
        expect(response).to redirect_to(edit_5_form_path(form))
      end
    end

    context 'when Save' do
      it 'successfully uploads any params and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_5, params: { id: form.id, form: { environment_video: video}, commit: 'Save' }
        form.reload
        expect(form.environment_video).to be_attached
        expect(response).to redirect_to(edit_5_form_path(form))
      end
    end

    context 'when Next' do
      it 'successfully uploads any params and redirects' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm1.mp4'), 'video/mp4')
        patch :update_5, params: { id: form.id, form: { environment_video: video}, commit: 'Next' }
        form.reload
        expect(form.environment_video).to be_attached
        expect(response).to redirect_to("/forms/#{form.id}")
      end
    end
  end

  describe 'PATCH #update_5_collection' do
    context 'when upload video button' do
      xit 'creates and saves a new form, and redirects to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { environment_video: video }, commit: 'Upload Environment Video' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_4_form_path(Form.last))
      end
    end
    context 'when saving' do
      xit 'creates and saves a new form, and redirects to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { environment_video: video }, commit: 'Save' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_4_form_path(Form.last))
      end
    end

    context 'when moving to next step' do
      xit 'creates and saves a new form, and redirects to edit_5' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { environment_video: video }, commit: 'Save' }
        expect(Form.count).to eq(1)
        expect(response).to redirect_to(edit_5_form_path(Form.last))
      end

      xspecify 'if no params, redirect to edit_5_forms_path without saving form' do 
        patch :update_4_collection, params: { id: form.id, form: {}, commit: 'Save' }
        expect(Form.count).to eq(0)
        expect(response).to redirect_to(edit_5_forms_path)
      end
    end

    context 'when no valid action' do
      xit 'renders to edit_4' do
        video = fixture_file_upload(Rails.root.join('spec/fixtures/files/videoUploadForm2.mp4'), 'video/mp4')
        patch :update_4_collection, params: { id: form.id, form: { environment_video: video }, commit: '' }
        expect(Form.count).to eq(0)
        expect(response).to render_template(:edit_4)
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
end