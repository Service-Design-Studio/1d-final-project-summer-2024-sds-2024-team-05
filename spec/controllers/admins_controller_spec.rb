require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

  let(:admin) { create(:user, email: "nursejoon@ninkatec.com", admin: true) }
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

#   describe 'GET #_physical_assessment' do
#   it 'assigns the requested form to @form' do
#     get :edit_physical_assessment, params: { id: form.id }
#     expect(assigns(:form)).to eq(form)
#   end

#   it 'renders the _physical_assessment partial' do
#     get :edit_physical_assessment, params: { id: form.id }
#     expect(response).to render_template(:'_physical_assessment')
#   end
# end

#   describe 'PATCH #update_physical_assessment' do
#     context 'when Save is clicked' do
#       it 'updates the form and redirects to client_profile' do
#         patch :update_physical_assessment, params: { id: form.id, form: { physical_assessment: 'Good' }, commit: 'Save' }
#         expect(form.reload.physical_assessment).to eq('Good')
#         expect(response).to redirect_to(client_profile_form_path(status: 'Pending Assessment'))
#       end
#     end

#     context 'when invalid action' do
#       it 'redirects to physical_assessment_path with alert' do
#         patch :update_physical_assessment, params: { id: form.id, form: { physical_assessment: 'Good' }, commit: 'Invalid' }
#         expect(response).to redirect_to(physical_assessment_path)
#       end
#     end
#   end

#   describe 'GET #_mental_assessment' do
#     it 'assigns the requested form to @form' do
#       get :_mental_assessment, params: { id: form.id }
#       expect(assigns(:form)).to eq(form)
#     end

#     it 'renders the _mental_assessment partial' do
#       get :_mental_assessment, params: { id: form.id }
#       expect(response).to render_template(:'_mental_assessment')
#     end
#   end

#   describe 'PATCH #update_mental_assessment' do
#     context 'when Save is clicked' do
#       it 'updates the form and redirects to client_profile' do
#         patch :update_mental_assessment, params: { id: form.id, form: { mental_assessment: 'Good' }, commit: 'Save' }
#         expect(form.reload.mental_assessment).to eq('Good')
#         expect(response).to redirect_to(client_profile_form_path(status: 'Pending Assessment'))
#       end
#     end

#     context 'when invalid action' do
#       it 'redirects to mental_assessment_path with alert' do
#         patch :update_mental_assessment, params: { id: form.id, form: { mental_assessment: 'Good' }, commit: 'Invalid' }
#         expect(response).to redirect_to(mental_assessment_path)
#       end
#     end
#   end

#   describe 'GET #_environment_assessment' do
#     it 'assigns the requested form to @form' do
#       get :_environment_assessment, params: { id: form.id }
#       expect(assigns(:form)).to eq(form)
#     end

#     it 'renders the _environment_assessment partial' do
#       get :_environment_assessment, params: { id: form.id }
#       expect(response).to render_template(:'_environment_assessment')
#     end
#   end

#   describe 'PATCH #update_environment_assessment' do
#     context 'when Save is clicked' do
#       it 'updates the form and redirects to client_profile' do
#         patch :update_environment_assessment, params: { id: form.id, form: { environment_assessment: 'Good' }, commit: 'Save' }
#         expect(form.reload.environment_assessment).to eq('Good')
#         expect(response).to redirect_to(client_profile_form_path(status: 'Pending Assessment'))
#       end
#     end

#     context 'when invalid action' do
#       it 'redirects to environment_assessment_path with alert' do
#         patch :update_environment_assessment, params: { id: form.id, form: { environment_assessment: 'Good' }, commit: 'Invalid' }
#         expect(response).to redirect_to(environment_assessment_path)
#       end
#     end
#   end

end