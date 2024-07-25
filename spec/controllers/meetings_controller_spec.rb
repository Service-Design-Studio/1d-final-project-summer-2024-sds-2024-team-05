require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  let(:admin) { User.find_by(email: "nursejoon@ninkatec.com") }
  let!(:meeting) { FactoryBot.create(:meeting) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'assigns all meetings to @meetings' do
      get :index
      expect(assigns(:meetings)).to include(meeting)
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'initializes a new meeting' do
      get :new
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end


  describe 'POST #create' do
  let(:user) { create(:user, email: "testing@gmail.com" ) }
  let!(:form) { create(:form, user: user) }
    context 'with valid parameters' do
      it 'creates a new meeting' do
        meeting_params = attributes_for(:meeting, title: 'Important Meeting', location: 'Board Room', start_time: DateTime.now + 2.days, form: form)
        expect {post :create, params: { meeting: meeting_params }}.to change(Meeting, :count).by(1)
      end

      it 'redirects to the client profile form if form_id is present' do
        meeting_params = attributes_for(:meeting, title: 'Important Meeting', location: 'Board Room', start_time: DateTime.now + 2.days, form_id: form.id)
        post :create, params: { meeting: meeting_params }
        expect(response).to redirect_to(client_profile_form_path(form, status: 'Meeting Date Pending'))
      end

      it 'redirects to the meetings index if form_id is not present' do
        meeting_params = attributes_for(:meeting, title: 'Important Meeting', location: 'Board Room', start_time: DateTime.now + 2.days, form_id: form.id)
        meeting_params.delete(:form_id)
        post :create, params: { meeting: meeting_params }
        expect(response).to redirect_to(meetings_url)
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        post :create, params: { meeting: { title: '' } }  # Invalid parameters
        expect(response).to render_template(:new)
      end
    end
  end


  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the meeting' do
        patch :update, params: { id: meeting.id, meeting: { title: 'New Title' } }
        meeting.reload
        expect(meeting.title).to eq('New Title')
      end

      it 'redirects to the meeting' do
        patch :update, params: { id: meeting.id, meeting: { title: 'New Title' } }
        expect(response).to redirect_to(meeting_url(meeting))
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        patch :update, params: { id: meeting.id, meeting: { title: '' } }  # Invalid parameters
        expect(response).to render_template(:edit)
      end
    end
  end


  describe 'DELETE #destroy' do
  let(:user) { create(:user, email: "testing1@gmail.com" ) }
  let!(:form) { create(:form, user: user) }
    context 'when origin is present' do
      it 'destroys the meeting and redirects to the client profile form' do
        delete :destroy, params: { id: meeting.id, origin: form.id }
        expect(Meeting.exists?(meeting.id)).to be(false)
        expect(response).to redirect_to(client_profile_form_path(form))
      end
    end

    context 'when origin is not present' do
      it 'destroys the meeting and redirects to the meetings index' do
        delete :destroy, params: { id: meeting.id }
        expect(Meeting.exists?(meeting.id)).to be(false)
        expect(response).to redirect_to(meetings_url)
      end
    end
  end


end