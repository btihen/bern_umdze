require 'rails_helper'

RSpec.describe "Participants::MagicLinks", type: :request do
  let(:new_attributes)  { {email: "test@test.ch"} }

  describe "GET /participants/magic_links/new" do
    it "returns http success" do
      get new_participants_magic_link_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
    end
  end

  describe "POST /create" do

    it "returns to new magic link without an email without creating a Participant" do
      new_attributes[:email] = ""
      post participants_magic_links_path, params: { participant: new_attributes }

      expect(response).to have_http_status(:success)
      expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
      expect(Participant.count).to eq 0
    end

    it "returns to new magic link with an invalid email without creating a Participant" do
      new_attributes[:email] = "bill"
      post participants_magic_links_path, params: { participant: new_attributes }

      expect(response).to have_http_status(:success)
      expect(response.body).to include "<p hidden id='new-participant-magic-link' class='pageName'>New Participant Magic Link</p>"
      expect(Participant.count).to eq 0
    end

    it "returns http success with a valid email" do
      post participants_magic_links_path, params: { participant: new_attributes }

      expect(response.status).to eq(302) #redirected
      expect(response).to redirect_to(landing_path)

      # be sure participant is properly created
      expect(Participant.count).to eq 1
      participant = Participant.last
      expect(participant.fullname).to be nil
      expect(participant.email).to eq(new_attributes[:email])
    end
  end

end
