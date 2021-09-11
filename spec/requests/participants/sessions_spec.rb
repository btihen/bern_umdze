require 'rails_helper'

RSpec.describe "Participants::Sessions", type: :request do
  describe "DESTROY /participants/sessions/:id" do
    xit "particpant logout" do
    end
  end
  describe "GET /participants/sessions/:token" do
    let(:participant) { FactoryBot.create :participant }
    it "redirects to magic link when token not found" do
      get "/participants/sessions/1234567890"

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(new_participants_magic_link_path)

      # expect(response).to have_http_status(:success)
      # expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
    it "redirects to magic link when token expired" do
      participant.token_valid_until = DateTime.now - 1.hour
      participant.save
      get "/participants/sessions/#{participant.login_token}"

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(new_participants_magic_link_path)

      # expect(response).to have_http_status(:success)
      # expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
    it "redirects to participant profile when token valid and name is missing" do
      participant.fullname = nil
      participant.save
      get "/participants/sessions/#{participant.login_token}"

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(participants_home_path)

      follow_redirect!  # ensure that the central controller redirects to profile
      expect(response).to redirect_to(edit_participants_profile_path(participant))

      # expect(response).to have_http_status(:success)
      # expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
    it "redirects to participant home when token valid and account complete" do
      participant.fullname = "Nyima"
      participant.save
      get "/participants/sessions/#{participant.login_token}"

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(participants_home_path)

      # expect(response).to have_http_status(:success)
      # expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
  end

end
