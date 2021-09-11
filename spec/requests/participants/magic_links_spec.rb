require 'rails_helper'

RSpec.describe "Participants::MagicLinks", type: :request do
  let(:new_attributes)  { {email: "test@test.ch"} }
  describe "GET /new" do
    it "returns http success" do
      get "/participants/magic_links/new"
      expect(response).to have_http_status(:success)
      expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
  end
  describe "POST /create" do
    it "returns http success with a valid email" do
      post participants_magic_links_path, params: { participant: new_attributes }

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(landing_path)

      # be sure participant is properly created
      participant = Participant.last
      expect(participant.email).to eq(new_attributes[:email])
    end
  end

end
