require 'rails_helper'

RSpec.describe "Patients", type: :request do

  let(:user) { create(:user) }
  let!(:form) { create(:form, user: user) }

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
  describe "GET /new" do
    it "Signed in user renders a successful response" do
      get new_form_path # Assuming `patients_path` is the route to your index action
      expect(response).to be_successful
    end

    it "Signed out user renders an unsuccessful response" do
      sign_out user
      get new_form_path
      expect(response).not_to be_successful # Assuming the page requires authentication
    end
  end

  describe "GET /edit_1" do
    it "Signed in user renders a successful response" do
      get edit_1_form_path(form) # Assuming `patients_path` is the route to your index action
      expect(response).to be_successful
    end

    it "Signed out user renders an unsuccessful response" do
      sign_out user
      get edit_1_form_path(form)
      expect(response).not_to be_successful # Assuming the page requires authentication
    end
  end

  describe "PATCH /update_1" do
    it "updates the form and redirects for 'Save'" do
      expect(form.first_name).to eq("John")
      patch edit_1_form_path(form), params: { form: { first_name: "Jane" }, commit: 'Save' }
      form.reload
      expect(form.first_name).to eq("Jane")
    end
  
    it "updates the form and redirects for 'Next'" do
      expect(form.first_name).to eq("John")
      expect(form.last_name).to eq("Doe")
      patch edit_1_form_path(form), params: { form: { last_name: "Tan" }, commit: 'Next' }
      form.reload
      expect(form.last_name).to eq("Tan")
    end
  
    it "renders edit_1 on validation error" do
      patch edit_1_form_path(form), params: { form: { first_name: "Jack" }, commit: '' }
      form.reload
      expect(form.first_name).not_to eq("Jack")  # Make sure form state is unchanged on error
    end
  end

  describe "GET /edit_2" do
    it "Signed in user renders a successful response" do
      get edit_2_form_path(form) # Assuming `patients_path` is the route to your index action
      expect(response).to be_successful
    end

    it "Signed out user renders an unsuccessful response" do
      sign_out user
      get edit_2_form_path(form)
      expect(response).not_to be_successful # Assuming the page requires authentication
    end
  end

  describe "PATCH /update_2" do
    it "updates the form and redirects for 'Save'" do
      expect(form.height).to eq(160)
      patch edit_2_form_path(form), params: { form: { height: 180 }, commit: 'Save' }
      expect(response).to redirect_to(edit_2_form_path(form))
      form.reload
      expect(form.height).to eq(180)
    end
  
    it "updates the form and redirects for 'Next'" do
      expect(form.weight).to eq(75)
      patch edit_2_form_path(form), params: { form: { weight: 80 }, commit: 'Next' }
      expect(response).to redirect_to(edit_3_form_path(form))
      form.reload
      expect(form.weight).to eq(80)
    end
  
    it "renders edit_1 on validation error" do
      patch edit_2_form_path(form), params: { form: { weight: 100 }, commit: '' }
      form.reload
      expect(form.weight).to eq(75)
      expect(form.weight).not_to eq(100) 
    end
  end

  describe "GET /edit_3" do
    it "Signed in user renders a successful response" do
      get edit_3_form_path(form) # Assuming `patients_path` is the route to your index action
      expect(response).to be_successful
    end

    it "Signed out user renders an unsuccessful response" do
      sign_out user
      get edit_3_form_path(form)
      expect(response).not_to be_successful # Assuming the page requires authentication
    end
  end

  describe "PATCH /update_3" do
    it "updates the form and redirects for 'Save'" do
      expect(form.end_date).to eq(Date.today + 30)
      patch edit_3_form_path(form), params: { form: { end_date: (Date.today + 60) }, commit: 'Save' }
      expect(response).to redirect_to(edit_3_form_path(form))
      form.reload
      expect(form.end_date).to eq(Date.today + 60)
    end
  
    it "updates the form and redirects for 'Next'" do
      expect(form.end_date).to eq(Date.today + 30)
      patch edit_3_form_path(form), params: { form: { end_date: (Date.today + 70) }, commit: 'Next' }
      expect(response).to redirect_to(edit_4_form_path(form))
      form.reload
      expect(form.end_date).to eq(Date.today + 70)
    end
  
    it "renders edit_1 on validation error" do
      patch edit_3_form_path(form), params: { form: { end_date: (Date.today + 70) }, commit: '' }
      form.reload
      expect(form.end_date).to eq(Date.today + 30)
      expect(form.end_date).not_to eq(Date.today + 70)
    end
  end

  # describe "another user cannot access other user form" do
  #   #another user without a form
  #   let(:another_user) { create(:user, email: "testing@gmail.com") }
  #   it "allows signed in user to access their own form" do
  #     get edit_1_form_path(form)
  #     expect(response).to be_successful
  #   end

  #   it "does not allow another user to access the form" do
  #     sign_out user
  #     sign_in another_user

  #     get edit_1_form_path(form)
  #     expect(response).to have_http_status(:unauthorized)
  #   end
  # end

end
