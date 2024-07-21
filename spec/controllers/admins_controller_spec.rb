require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

  let(:admin) { create(:user, admin: true) }

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

end