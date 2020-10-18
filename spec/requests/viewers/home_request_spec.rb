require 'rails_helper'

RSpec.describe "Viewers::Home - route '/'", type: :request do

  describe "logged in as a 'viewer'" do
    let(:viewer)  { FactoryBot.create :user, access_role: "viewer" }
    before do
      sign_in viewer
    end
    after do
      sign_out viewer
    end

    it "returns http success on Viewer's Home Agenda page" do
      get root_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("<p hidden id='viewer_home' class='pageName'>Viewer-#{viewer.id} Home</p>")
    end
  end

end
