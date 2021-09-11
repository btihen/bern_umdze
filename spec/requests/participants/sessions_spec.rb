require 'rails_helper'

RSpec.describe "Participants::Sessions", type: :request do
  describe "GET /participants/sessions/:token" do
    it "redirects to magic link when token invalid" do
      get "/participants/sessions/1234567890"

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(new_participants_magic_link_path)

      # expect(response).to have_http_status(:success)
      # expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
  end

end
