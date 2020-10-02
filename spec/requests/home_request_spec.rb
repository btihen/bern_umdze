require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "GET /home - NOT loged-in" do
    it "returns http success" do
      get home_path
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("Log in")
      # expect(current_path).to eq(new_user_session_path)
      # expect(response.body).to include("<p hidden id='landing_index'>Landing Index</p>")
    end
  end

  describe "GET /home - logged in" do
    let(:user)  { FactoryBot.create :user }
    before do
      sign_in user
    end
    after do
      sign_out user
    end
    it "returns http success" do
      get home_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='home_index'>Home Index</p>")
    end
  end

end
