require 'rails_helper'

RSpec.describe "Patients", type: :request do

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "Signed in user renders a successful response" do
      get forms_path # Assuming `patients_path` is the route to your index action
      expect(response).to be_successful
    end

    it "Signed out user renders an unsuccessful response" do
      sign_out user
      get forms_path
      expect(response).not_to be_successful # Assuming the page requires authentication
    end
  end
end
