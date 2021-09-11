require 'rails_helper'

RSpec.describe "Participants::Profiles", type: :request do

  describe "GET /edit" do
    let(:participant)   { FactoryBot.create :participant}
    it "returns http success" do
      # get "/participants/profiles/1/edit"
      get "/participants/profiles/#{participant.id}/edit"
      # expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    # context "with valid parameters" do
    #   let(:new_attributes) {
    #     { username: "new_usernane" }
    #   }

    #   it "updates the requested managers_user" do
    #     user = User.create! valid_attributes
    #     patch managers_user_url(user), params: { user: new_attributes }
    #     user.reload
    #     expect(user.username).to eq new_attributes[:username]
    #   end

    #   it "redirects to the managers_user index page" do
    #     user = User.create! valid_attributes
    #     patch managers_user_url(user), params: { user: new_attributes }
    #     user.reload
    #     expect(response).to redirect_to(managers_users_url)
    #   end
    # end
  end

end
